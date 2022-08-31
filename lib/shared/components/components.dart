import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/modules/news_app/web_view/webView_screen.dart';
import 'package:news_app/shared/styles/colors.dart';


Widget defultButtun ({
    double width =double.infinity,

   Color background=Colors.blue ,
  bool isUpperCase=true,
  double radius=5.0,
  required void Function()?  function,
  required String text,
})=> Container(
  width: width,


  child: MaterialButton(
    onPressed : function ,
    child: Text(
      isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),

  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius), color:  background,

  ),

);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType Type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
    void Function()?  onTap,
  required String? Function (String?)? validate,
  required String lable,
  bool isPassword=false,
  required IconData prefix ,
  void Function()? suffixPressed,
  bool isClickable =true,
  IconData? suffix,
})=> TextFormField(
controller: controller,
keyboardType: Type,
  obscureText: isPassword,
onFieldSubmitted:onSubmit,
onChanged:onChange,
onTap: onTap,
enabled:isClickable ,
validator: validate,
decoration: InputDecoration(
labelText: lable ,labelStyle: TextStyle(fontWeight: FontWeight.bold,),
prefixIcon: Icon(
prefix,
),
  suffixIcon: suffix!= null ? IconButton(
    onPressed: suffixPressed,
    icon: Icon(
      suffix,
    ),
  ):null,
border: OutlineInputBorder(

),
),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article,context)=> InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image: DecorationImage(

                image: NetworkImage

                  ('${article['urlToImage']}',),

                fit: BoxFit.cover,

              )

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [



                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines:3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),



              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition:list.length>0,
  builder: (context)=>ListView.separated(

    physics: BouncingScrollPhysics(),

    itemBuilder: (  context,  index)=>buildArticleItem(list[index],context),
    separatorBuilder: (  context,   index) =>myDivider() ,
    itemCount: 10 ,
  ),
  fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator()),
);
void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> Widget,
  ),
);
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=> widget,
    ),
     (Route<dynamic> route) => false,

    );
Widget defaulTextButtom({
  required void Function() function,
  required String text,
 v
})=> TextButton(
  onPressed: function,
  child: Text(
    text.toUpperCase(),
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
);


void showToast({
  required String text,
  required ToastStates state,



})=> Fluttertoast.showToast(
  msg:  text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{SUCCESS,ERROR,WORNING}

Color ?chooseToastColor(ToastStates state)
{
  Color color;
switch(state)
{
  case ToastStates.SUCCESS:
    color= Colors.green;
    break;
  case ToastStates.ERROR:
    color= Colors.red;
    break;
  case ToastStates.WORNING:
    color= Colors.yellow;
    break;
}
return color;
}
