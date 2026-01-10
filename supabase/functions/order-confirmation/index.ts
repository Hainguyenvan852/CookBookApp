import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from './service-account.json' with { type: 'json' }

interface Recipe {
  id: string
  igm_url: string
  dish_name: string
  profile_id: string
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: Recipe
  schema: 'public'
  old_record: null | Recipe
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  try {
    const payload: WebhookPayload = await req.json()

    // 1. Lấy token từ database
    const { data, error } = await supabase
      .from('Profiles')
      .select('fcm_token')
      .eq('id', payload.record.profile_id)
      .single()

    if (error || !data?.fcm_token) {
      return new Response(JSON.stringify({ error: 'Token not found' }), { status: 404 })
    }

    const fcm_token = data.fcm_token

    // 2. Lấy Access Token
    const accessToken = await getAccessToken({
      clientEmail: serviceAccount.client_email,
      privateKey: serviceAccount.private_key
    })

    // 3. Gửi thông báo qua FCM HTTP v1
    const PROJECT_ID = serviceAccount.project_id 
    const res = await fetch(`https://fcm.googleapis.com/v1/projects/${PROJECT_ID}/messages:send`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${accessToken}`
      },
      body: JSON.stringify({
        message: {
          token: fcm_token,
          notification: {
            title: 'A new interesting recipe for you',
            body: `Check out ${payload.record.dish_name} recipe!`
          }
        }
      })
    })

    const resData = await res.json()
    return new Response(JSON.stringify(resData), {
      status: res.status,
      headers: { "Content-Type": "application/json" },
    })

  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500 })
  }
})

async function getAccessToken({ clientEmail, privateKey }: { clientEmail: string, privateKey: string }): Promise<string> {
  const jwtClient = new JWT({
    email: clientEmail,
    key: privateKey,
    scopes: ['https://www.googleapis.com/auth/firebase.messaging']
  })
  const tokens = await jwtClient.authorize()
  if (!tokens.access_token) throw new Error('Failed to get FCM access token')
  return tokens.access_token
}