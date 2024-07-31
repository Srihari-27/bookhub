import 'package:flutter/material.dart';
import 'package:bookhub/providers/users_provider.dart';
import 'package:bookhub/services/auth_services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:bookhub/custom_textfield.dart';


String a ='';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  
  final AuthService authService = AuthService();

  void update1(String a) {
    
    authService.update1(
      

      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      id: a,
      
    );
  }
  void delete1(String a){
    authService.delete1(
      context:context,
      id:a,
      );
  }
  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    
    return Scaffold(
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: nameController,
              hintText: user.name,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            
            child: CustomTextField(
              controller: emailController,
              hintText: user.email,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'enter password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:(){
              String a=user.id;
              update1(a);
              
            },
            child:Text('Update'),
          ),
          ElevatedButton(
            onPressed:(){
               String a=user.id;
               delete1(a);
               signOutUser(context);
            },
            child:Text('Delete'),
          ),

          
          ElevatedButton(
            onPressed: () => signOutUser(context),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              textStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}