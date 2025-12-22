import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final fieldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: fieldKey,
            child: TextFormField(
              style: const TextStyle(color: Colors.white), // Màu chữ nhập
              decoration: InputDecoration(
                hintText: 'Full Name',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.person, color: Colors.grey),

                helperText: '',
                helperStyle: const TextStyle(fontSize: 0),

                // 2. CỐ ĐỊNH NỘI DUNG: Dùng contentPadding để icon và text luôn ở giữa phần input chính
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),

                // 3. STYLE ERROR: Đặt height nhỏ để không đẩy layout thêm một lần nữa
                errorStyle: const TextStyle(height: 0.8, color: Colors.redAccent),

                // 4. TRANG TRÍ (Giống ảnh bạn cung cấp)
                filled: true,
                fillColor: const Color(0xFF1A241E), // Màu nền tối (tùy chỉnh theo ảnh)
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50), // Bo tròn cực đại
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.white24, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.green, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(onPressed: (){
            fieldKey.currentState!.validate();
          }, child: Text('Validate'))
        ],
      ),
    );
  }
}
