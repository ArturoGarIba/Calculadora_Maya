// Programa que simula una calculadora haciendo uso de la numeracion maya
/**
* 
*
* @author  Arturo García Ibarra
* @version 1.0
* @since   Mayo/2021
*/
import controlP5.*;
ControlP5 cp5;
//Declaramos los botones que usamos para ingresar los números y las operaciones
Button btn0,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10,btn11,btn12,btn13,btn14,btn15,btn16,btn17,btn18,btn19;
Button btnSuma,btnResta,btnMultiplicacion,btnDivision,btnIgual,btnEliminar,btnBorrar,btnLimpiar;
// Arreglo que contiene los shaders 
String[] shaders = new String[] {
  "brcosa.glsl", "hue.glsl", "pixelate.glsl", "blur.glsl", 
  "channels.glsl", "threshold.glsl", "neon.glsl", "edges.glsl",
  "wrap.glsl", "deform.glsl", "pixelrolls.glsl", "patches.glsl", 
  "modcolor.glsl", "halftone.glsl", "halftone_cmyk.glsl", "invert.glsl", "bilateral_filter.glsl"};
PShader shade;
//Variables para llevar el control del shader seleccionado así como la imagen
int idxSource = 0;
int idxShader = 1;

PImage img0,img1,img2,img3,img4,img5,img6,img7,img8,img9,img10;
PImage img11,img12,img13,img14,img15,img16,img17,img18,img19, imgMaya,imgMaya2,imgMaya3, imgSuma, imgResta, imgMulti,imgDivi, imgIgual,imgIgual2, imgBorrar, imgEliminar;
PImage num1,num2,num3,num4,num5,num6;
int boton=-1;
float r=0;
int r2=0;
int msj=0;
int nivel=0,nivel2=0,nivel3=0,nivel4=0;
String op="",op2="";
float total=0,total2=0,resultado=0, resultadoR=0;
int tot1=0,tot2=0;
//Arreglos que ayuda guardar los valores de los numeros con los que haremos las operaciones
int[] valores1= new int[5];
int[] valores2= new int[5];
//Arreglos donde guardamos resultados
int[] total3= new int[6];
int[] total4= new int[5];
//Arreglos que contiene posiciones que usamos para darle valores "x, y" a las imagenes
int[] nivel11=new int[2];
int[] nivel12=new int[2];
int[] nivel13=new int[2];
int[] nivel14=new int[2];
int[] nivel15=new int[2];
int[] nivel21=new int[2];
int[] nivel22=new int[2];
int[] nivel23=new int[2];
int[] nivel24=new int[2];
int[] nivel25=new int[2];

//Variable para saber si se ha seleccionado alguna operacion
boolean operacion=false;
void setup(){
  size(1200,650,P3D);
  //funcion donde instanciamos los botones
  definirBotones();
  //funcion donde instanciamos las imagenes
  definirImagenes();
  //Funciones donde llenamos los arreglos de las posiciones que usaremos para las imagenes
  llenadoNivel1(); 
  llenadoValores1();
  llenadoNivel2(); 
  llenadoValores2();
  //Funcion donde agregamos los shaders al objeto shade
  setupShader();
  textureMode(NORMAL);
  fill(255);
  stroke(color(44,48,32));
}

void draw(){
  //Funcion donde se cambian las configuraciones de los shaders dependiendo de cual esté seleccinado
  setShaderParameters();
//Aplicacion de el sombreador dependiendo de cual esté seleccionado
  shader(shade);
  if      (idxSource == 0)  image(imgMaya, 0, 0, width, height);
  else if (idxSource == 1)  image(imgMaya2, 0, 0, width, height);
  else if (idxSource == 2)  image(imgMaya3, 0, 0, width, height);

  resetShader();
  
  //text(shaders[idxShader], 5, 20);
  //
  dibujarImagenes();
  dibujarValores();
  
  sacarValores1();
  sacarValores2();
  sacarValores3();
  cantidades();
  mostrarValores1();
  mostrarValores2();
  mostrarValores3();
  mostrarImgResta();
  dibujarBotones();
  
  mostrarImgValor1();
  mostrarImgValor2();
  mostrarImgValor3();
  ImagenOperacion();
  MostrarMsj();
}
///////////////////////

  /**
    * Estas funciones sirven para sacar el valor de cada numero de cada nivel
    * @param numero que se le sacará su valor 
    * @return un valor de tipo flotante
    */
float nivel2(int num){
  float resultado=0;
  resultado= num* pow(20,1);
  return resultado;
}
float nivel3(int num){
  float resultado=0;
  resultado= num* pow(20,2);
  return resultado;
}
float nivel4(int num){
  float resultado=0;
  resultado= num* pow(20,3);
  return resultado;
}
float nivel5(int num){
  float resultado=0;
  resultado= num* pow(20,4);
  return resultado;
}
float nivel6(int num){
  float resultado=0;
  resultado= num* pow(20,5);
  return resultado;
}
  /**
    * Esta funcion grafica unos mensajes y rectangulos
    * @param args sin usar.
    * @return Nada.
    */
void cantidades(){
 fill(255);
 textSize(16);
  
  text("Flechas arriba y abajo, son para cambiar imagen",734,550);
  text("Flechas izquierda y derecha, son para cambiar filtro",750,600);
  
  stroke(0);
  fill(250);
 rect(270,330,100,25);
 rect(420,330,100,25);
 rect(570,380,100,25);
 
 text("Numero 1",310,305);
  text("Numero 2",460,305);
  text("Resultado",610,355);
fill(0);
}
  /**
    * Esta funcion se va ejecutar en la funcion mouseClicked( el cual se llama despues de presionar y soltar un botón del mouse)
    * @param args sin usar.
    * @return Nada.
    */
void seleccion(){

  if(nivel<5){
  if(btn0.MouseIsOver()){
    //println(msj);
      if(nivel>0){
       boton=0;
       msj=0;
       if(operacion==false){
       nivel++;
       }
      }else{
      boton=0;
      msj=2;
      }
  }else if(btn1.MouseIsOver()){
    boton=1;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
       
  }else if(btn2.MouseIsOver()){
    boton=2;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn3.MouseIsOver()){
     boton=3;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn4.MouseIsOver()){
    boton=4;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if( btn5.MouseIsOver()){
     boton=5;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if( btn6.MouseIsOver()){
    boton=6;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if( btn7.MouseIsOver()){
     boton=7;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if( btn8.MouseIsOver()){
     boton=8;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn9.MouseIsOver()){
     boton=9;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn10.MouseIsOver()){
    boton=10;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn11.MouseIsOver()){
    boton=11;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn12.MouseIsOver()){
   boton=12;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn13.MouseIsOver()){
    boton=13;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn14.MouseIsOver()){
    boton=14;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn15.MouseIsOver()){
    boton=15;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn16.MouseIsOver()){
    boton=16;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn17.MouseIsOver()){
    boton=17;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn18.MouseIsOver()){
    boton=18;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }else if(btn19.MouseIsOver()){
   boton=19;
    msj=0;
    if(operacion==false){
       nivel++;
       
       }
  }
  }
  
  //////////////////////////////////////////
  if(operacion==true){
  if(nivel2<5){
  if(btn0.MouseIsOver()){
      if(nivel2>0){
       boton=0;
       msj=0;
       nivel2++;
       
      }else{
      boton=0;
      msj=2;
      }
  }else if(btn1.MouseIsOver()){
   
    if(operacion==true){
         boton=1;
         nivel2++;
         msj=0;
       }
  }else if(btn2.MouseIsOver()){
     if(operacion==true){
         boton=2;
         nivel2++;
         msj=0;
       }
  }else if(btn3.MouseIsOver()){
     if(operacion==true){
         boton=3;
         nivel2++;
         msj=0;
       }
  }else if(btn4.MouseIsOver()){
    if(operacion==true){
         boton=4;
         nivel2++;
         msj=0;
       }
  }else if( btn5.MouseIsOver()){
    if(operacion==true){
         boton=5;
         nivel2++;
         msj=0;
       }
  }else if( btn6.MouseIsOver()){
     if(operacion==true){
         boton=6;
         nivel2++;
         msj=0;
       }
  }else if( btn7.MouseIsOver()){
    if(operacion==true){
         boton=7;
         nivel2++;
         msj=0;
       }
  }else if( btn8.MouseIsOver()){
     if(operacion==true){
         boton=8;
         nivel2++;
         msj=0;
       }
  }else if(btn9.MouseIsOver()){
    if(operacion==true){
         boton=9;
         nivel2++;
         msj=0;
       }
  }else if(btn10.MouseIsOver()){
     if(operacion==true){
         boton=10;
         nivel2++;
         msj=0;
       }
  }else if(btn11.MouseIsOver()){
     if(operacion==true){
         boton=11;
         nivel2++;
         msj=0;
       }
  }else if(btn12.MouseIsOver()){
    if(operacion==true){
         boton=12;
         nivel2++;
         msj=0;
       }
  }else if(btn13.MouseIsOver()){
     if(operacion==true){
         boton=13;
         nivel2++;
         msj=0;
       }
  }else if(btn14.MouseIsOver()){
     if(operacion==true){
         boton=14;
         nivel2++;
         msj=0;
       }
  }else if(btn15.MouseIsOver()){
     if(operacion==true){
         boton=15;
         nivel2++;
         msj=0;
       }
  }else if(btn16.MouseIsOver()){
     if(operacion==true){
         boton=16;
         nivel2++;
         msj=0;
       }
  }else if(btn17.MouseIsOver()){
     if(operacion==true){
         boton=17;
         nivel2++;
         msj=0;
       }
  }else if(btn18.MouseIsOver()){
     if(operacion==true){
         boton=18;
         nivel2++;
         msj=0;
       }
  }else if(btn19.MouseIsOver()){
     if(operacion==true){
         boton=19;
         nivel2++;
         msj=0;
       }
  }
  }
  }
  //////////////////////////////////////////////////////7
  if(operacion==false){
  if(boton==0){
    if(nivel==1){////////////////////////0
     
   }else if(nivel==2){
     valores1[1]=0;
     
   }else if(nivel==3){
     valores1[2]=0;
     
   }else if(nivel==4){
     valores1[3]=0;
     
   }else if(nivel==5){
     valores1[4]=0;
    
   }
 }else if(boton==1){////////////////////////1
   if(nivel==1){
     valores1[0]=1;
     
   }else if(nivel==2){
     valores1[1]=1;
   
   }else if(nivel==3){
     valores1[2]=1;
     
   }else if(nivel==4){
     valores1[3]=1;
     
   }else if(nivel==5){
     valores1[4]=1;
     
   }
 }else if(boton==2){//////////////////////// 2
   if(nivel==1){
     valores1[0]=2;
   }else if(nivel==2){
     valores1[1]=2;
   }else if(nivel==3){
     valores1[2]=2;
   }else if(nivel==4){
     valores1[3]=2;
   }else if(nivel==5){
     valores1[4]=2;
   }
 }else if(boton==3){//////////////////////// 3
   if(nivel==1){
     valores1[0]=3;
   }else if(nivel==2){
     valores1[1]=3;
   }else if(nivel==3){
     valores1[2]=3;
   }else if(nivel==4){
     valores1[3]=3;
   }else if(nivel==5){
     valores1[4]=3;
   }
 }else if(boton==4){//////////////////////// 4
   if(nivel==1){
     valores1[0]=4;
   }else if(nivel==2){
     valores1[1]=4;
   }else if(nivel==3){
     valores1[2]=4;
   }else if(nivel==4){
     valores1[3]=4;
   }else if(nivel==5){
     valores1[4]=4;
   }
 }else if(boton==5){//////////////////////// 5
   if(nivel==1){
     valores1[0]=5;
   }else if(nivel==2){
     valores1[1]=5;
   }else if(nivel==3){
     valores1[2]=5;
   }else if(nivel==4){
     valores1[3]=5;
   }else if(nivel==5){
     valores1[4]=5;
   }
 }else if(boton==6){//////////////////////// 6
   if(nivel==1){
     valores1[0]=6;
   }else if(nivel==2){
     valores1[1]=6;
   }else if(nivel==3){
     valores1[2]=6;
   }else if(nivel==4){
     valores1[3]=6;
   }else if(nivel==5){
     valores1[4]=6;
   }
 }else if(boton==7){ //////////////////////// 7
   if(nivel==1){
     valores1[0]=7;
   }else if(nivel==2){
     valores1[1]=7;
   }else if(nivel==3){
     valores1[2]=7;
   }else if(nivel==4){
     valores1[3]=7;
   }else if(nivel==5){
     valores1[4]=7;
   }
 }else if(boton==8){//////////////////////// 8
   if(nivel==1){
     valores1[0]=8;
   }else if(nivel==2){
     valores1[1]=8;
   }else if(nivel==3){
     valores1[2]=8;
   }else if(nivel==4){
     valores1[3]=8;
   }else if(nivel==5){
     valores1[4]=8;
   }
 }else if(boton==9){//////////////////////// 9
   if(nivel==1){
     valores1[0]=9;
   }else if(nivel==2){
     valores1[1]=9;
   }else if(nivel==3){
     valores1[2]=9;
   }else if(nivel==4){
     valores1[3]=9;
   }else if(nivel==5){
     valores1[4]=9;
   }
 }else if(boton==10){//////////////////////// 10
   if(nivel==1){
     valores1[0]=10;
   }else if(nivel==2){
     valores1[1]=10;
   }else if(nivel==3){
     valores1[2]=10;
   }else if(nivel==4){
     valores1[3]=10;
   }else if(nivel==5){
     valores1[4]=10;
   }
 }else if(boton==11){////////////////////////11 
   if(nivel==1){
     valores1[0]=11;
   }else if(nivel==2){
     valores1[1]=11;
   }else if(nivel==3){
     valores1[2]=11;
   }else if(nivel==4){
     valores1[3]=11;
   }else if(nivel==5){
     valores1[4]=11;
   }
 }else if(boton==12){//////////////////////// 12
   if(nivel==1){
     valores1[0]=12;
   }else if(nivel==2){
     valores1[1]=12;
   }else if(nivel==3){
     valores1[2]=12;
   }else if(nivel==4){
     valores1[3]=12;
   }else if(nivel==5){
     valores1[4]=12;
   }
 }else if(boton==13){//////////////////////// 13
   if(nivel==1){
     valores1[0]=13;
   }else if(nivel==2){
     valores1[1]=13;
   }else if(nivel==3){
     valores1[2]=13;
   }else if(nivel==4){
     valores1[3]=13;
   }else if(nivel==5){
     valores1[4]=13;
   }
 }else if(boton==14){//////////////////////// 14
   if(nivel==1){
     valores1[0]=14;
   }else if(nivel==2){
     valores1[1]=14;
   }else if(nivel==3){
     valores1[2]=14;
   }else if(nivel==4){
     valores1[3]=14;
   }else if(nivel==5){
     valores1[4]=14;
   }
 }else if(boton==15){//////////////////////// 15
   if(nivel==1){
     valores1[0]=15;
   }else if(nivel==2){
     valores1[1]=15;
   }else if(nivel==3){
     valores1[2]=15;
   }else if(nivel==4){
     valores1[3]=15;
   }else if(nivel==5){
     valores1[4]=15;
   }
 }else if(boton==16){////////////////////////16
   if(nivel==1){
     valores1[0]=16;
   }else if(nivel==2){
     valores1[1]=16;
   }else if(nivel==3){
     valores1[2]=16;
   }else if(nivel==4){
     valores1[3]=16;
   }else if(nivel==5){
     valores1[4]=16;
   }
 }else if(boton==17){////////////////////////17
   if(nivel==1){
     valores1[0]=17;
   }else if(nivel==2){
     valores1[1]=17;
   }else if(nivel==3){
     valores1[2]=17;
   }else if(nivel==4){
     valores1[3]=17;
   }else if(nivel==5){
     valores1[4]=17;
   }
 }else if(boton==18){////////////////////////18
   if(nivel==1){
     valores1[0]=18;
   }else if(nivel==2){
     valores1[1]=18;
   }else if(nivel==3){
     valores1[2]=18;
   }else if(nivel==4){
     valores1[3]=18;
   }else if(nivel==5){
     valores1[4]=18;
   }
 }else if(boton==19){////////////////////////19
   if(nivel==1){
     valores1[0]=19;
   }else if(nivel==2){
     valores1[1]=19;
   }else if(nivel==3){
     valores1[2]=19;
   }else if(nivel==4){
     valores1[3]=19;
   }else if(nivel==5){
     valores1[4]=19;
   }
 }
  
 
}else{
  if(op==""){
    msj=4;
  }else{
    
 if(boton==0){
    if(nivel2==1){////////////////////////0
     
   }else if(nivel2==2){
     valores2[1]=0;
     
   }else if(nivel2==3){
     valores2[2]=0;
     
   }else if(nivel2==4){
     valores2[3]=0;
     
   }else if(nivel2==5){
     valores2[4]=0;
    
   }
 }else if(boton==1){////////////////////////1
   if(nivel2==1){
     valores2[0]=1;
     
   }else if(nivel2==2){
     valores2[1]=1;
   
   }else if(nivel2==3){
     valores2[2]=1;
     
   }else if(nivel2==4){
     valores2[3]=1;
     
   }else if(nivel2==5){
     valores2[4]=1;
     
   }
 }else if(boton==2){//////////////////////// 2
   if(nivel2==1){
     valores2[0]=2;
   }else if(nivel2==2){
     valores2[1]=2;
   }else if(nivel2==3){
     valores2[2]=2;
   }else if(nivel2==4){
     valores2[3]=2;
   }else if(nivel2==5){
     valores2[4]=2;
   }
 }else if(boton==3){//////////////////////// 3
   if(nivel2==1){
     valores2[0]=3;
   }else if(nivel2==2){
     valores2[1]=3;
   }else if(nivel2==3){
     valores2[2]=3;
   }else if(nivel2==4){
     valores2[3]=3;
   }else if(nivel2==5){
     valores2[4]=3;
   }
 }else if(boton==4){//////////////////////// 4
   if(nivel2==1){
     valores2[0]=4;
   }else if(nivel2==2){
     valores2[1]=4;
   }else if(nivel2==3){
     valores2[2]=4;
   }else if(nivel2==4){
     valores2[3]=4;
   }else if(nivel2==5){
     valores2[4]=4;
   }
 }else if(boton==5){//////////////////////// 5
   if(nivel2==1){
     valores2[0]=5;
   }else if(nivel2==2){
     valores2[1]=5;
   }else if(nivel2==3){
     valores2[2]=5;
   }else if(nivel2==4){
     valores2[3]=5;
   }else if(nivel2==5){
     valores2[4]=5;
   }
 }else if(boton==6){//////////////////////// 6
   if(nivel2==1){
     valores2[0]=6;
   }else if(nivel2==2){
     valores2[1]=6;
   }else if(nivel2==3){
     valores2[2]=6;
   }else if(nivel2==4){
     valores2[3]=6;
   }else if(nivel2==5){
     valores2[4]=6;
   }
 }else if(boton==7){ //////////////////////// 7
   if(nivel2==1){
     valores2[0]=7;
   }else if(nivel2==2){
     valores2[1]=7;
   }else if(nivel2==3){
     valores2[2]=7;
   }else if(nivel2==4){
     valores2[3]=7;
   }else if(nivel2==5){
     valores2[4]=7;
   }
 }else if(boton==8){//////////////////////// 8
   if(nivel2==1){
     valores2[0]=8;
   }else if(nivel2==2){
     valores2[1]=8;
   }else if(nivel2==3){
     valores2[2]=8;
   }else if(nivel2==4){
     valores2[3]=8;
   }else if(nivel2==5){
     valores2[4]=8;
   }
 }else if(boton==9){//////////////////////// 9
   if(nivel2==1){
     valores2[0]=9;
   }else if(nivel2==2){
     valores2[1]=9;
   }else if(nivel2==3){
     valores2[2]=9;
   }else if(nivel2==4){
     valores2[3]=9;
   }else if(nivel2==5){
     valores2[4]=9;
   }
 }else if(boton==10){//////////////////////// 10
   if(nivel2==1){
     valores2[0]=10;
   }else if(nivel2==2){
     valores2[1]=10;
   }else if(nivel2==3){
     valores2[2]=10;
   }else if(nivel2==4){
     valores2[3]=10;
   }else if(nivel2==5){
     valores2[4]=10;
   }
 }else if(boton==11){////////////////////////11 
   if(nivel2==1){
     valores2[0]=11;
   }else if(nivel2==2){
     valores2[1]=11;
   }else if(nivel2==3){
     valores2[2]=11;
   }else if(nivel2==4){
     valores2[3]=11;
   }else if(nivel2==5){
     valores2[4]=11;
   }
 }else if(boton==12){//////////////////////// 12
   if(nivel2==1){
     valores2[0]=12;
   }else if(nivel2==2){
     valores2[1]=12;
   }else if(nivel2==3){
     valores2[2]=12;
   }else if(nivel2==4){
     valores2[3]=12;
   }else if(nivel2==5){
     valores2[4]=12;
   }
 }else if(boton==13){//////////////////////// 13
   if(nivel2==1){
     valores2[0]=13;
   }else if(nivel2==2){
     valores2[1]=13;
   }else if(nivel2==3){
     valores2[2]=13;
   }else if(nivel2==4){
     valores2[3]=13;
   }else if(nivel2==5){
     valores2[4]=13;
   }
 }else if(boton==14){//////////////////////// 14
   if(nivel2==1){
     valores2[0]=14;
   }else if(nivel2==2){
     valores2[1]=14;
   }else if(nivel2==3){
     valores2[2]=14;
   }else if(nivel2==4){
     valores2[3]=14;
   }else if(nivel2==5){
     valores2[4]=14;
   }
 }else if(boton==15){//////////////////////// 15
   if(nivel2==1){
     valores2[0]=15;
   }else if(nivel2==2){
     valores2[1]=15;
   }else if(nivel2==3){
     valores2[2]=15;
   }else if(nivel2==4){
     valores2[3]=15;
   }else if(nivel2==5){
     valores2[4]=15;
   }
 }else if(boton==16){////////////////////////16
   if(nivel2==1){
     valores2[0]=16;
   }else if(nivel2==2){
     valores2[1]=16;
   }else if(nivel2==3){
     valores2[2]=16;
   }else if(nivel2==4){
     valores2[3]=16;
   }else if(nivel2==5){
     valores2[4]=16;
   }
 }else if(boton==17){////////////////////////17
   if(nivel2==1){
     valores2[0]=17;
   }else if(nivel2==2){
     valores2[1]=17;
   }else if(nivel2==3){
     valores2[2]=17;
   }else if(nivel2==4){
     valores2[3]=17;
   }else if(nivel2==5){
     valores2[4]=17;
   }
 }else if(boton==18){////////////////////////18
   if(nivel2==1){
     valores2[0]=18;
   }else if(nivel2==2){
     valores2[1]=18;
   }else if(nivel2==3){
     valores2[2]=18;
   }else if(nivel2==4){
     valores2[3]=18;
   }else if(nivel2==5){
     valores2[4]=18;
   }
 }else if(boton==19){////////////////////////19
   if(nivel2==1){
     valores2[0]=19;
   }else if(nivel2==2){
     valores2[1]=19;
   }else if(nivel2==3){
     valores2[2]=19;
   }else if(nivel2==4){
     valores2[3]=19;
   }else if(nivel2==5){
     valores2[4]=19;
   }
 } 
}
}

  /// fin if

boton=-1;

  
}

  /**
    * Funcion que grafica unos cuadrados que contendran los valores de las operaciones y el resultado
    * @param args sin usar.
    * @return Nada.
    */
void dibujarValores(){
 stroke(0);
 noFill();
 //Valor 1
 rect(300,50,30,30);
 rect(300,100,30,30);
 rect(300,150,30,30);
 rect(300,200,30,30);
 rect(300,250,30,30);
 //Operador
 rect(375,150,30,30);
 //Valor 2
 rect(450,50,30,30);
 rect(450,100,30,30);
 rect(450,150,30,30);
 rect(450,200,30,30);
 rect(450,250,30,30);
 //Igual
 rect(525,150,30,30);
 //Resultado
 rect(600,50,30,30);
 rect(600,100,30,30);
 rect(600,150,30,30);
 rect(600,200,30,30);
 rect(600,250,30,30);
 rect(600,300,30,30);
}

  /**
    * Funcion que grafica cubos con textura de imagenes de los numeros maya (0 al 19)
    * @param args sin usar.
    * @return Nada.
    */
void dibujarImagenes(){
  image(imgIgual2,525,150);
 // image(img1, 10, 90);
  //image(img2, 65, 90, 30, 30);
 // image(img3, 120, 90, 30, 30);
  //image(img4,175, 90, 30, 30);
  Rotacion(35,110,img1); 
  Rotacion(90,110,img2); 
  Rotacion(145,110,img3); 
  Rotacion(200,110,img4); 
 // image(img5,10, 170, 30, 30);
  //image(img6,65, 170, 30, 30);
  //image(img7,120, 170, 30, 30);
  //image(img8,175, 170, 30, 30);
  Rotacion(35,190,img5); 
  Rotacion(90,190,img6); 
  Rotacion(145,190,img7); 
  Rotacion(200,190,img8); 
 // image(img9,10, 250, 30, 30);
 // image(img10,65, 250, 30, 30);
 // image(img11,120,250, 30, 30);
 // image(img12,175, 250, 30, 30);
 Rotacion(35,270,img9); 
  Rotacion(90,270,img10); 
  Rotacion(145,270,img11); 
  Rotacion(200,270,img12); 
 // image(img13,10, 330, 30, 30);
 // image(img14,65, 330, 30, 30);
 // image(img15,120,330, 30, 30);
  //image(img16,175, 330, 30, 30);
  Rotacion(35,350,img13); 
  Rotacion(90,350,img14); 
  Rotacion(145,350,img15); 
  Rotacion(200,350,img16); 
  //image(img17,10, 410, 30, 30);
  //image(img18,65, 410, 30, 30);
  //image(img19,120, 410, 30, 30);
  //image(img0,175, 410, 30, 30);
  Rotacion(35,430,img17); 
  Rotacion(90,430,img18); 
  Rotacion(145,430,img19); 
  Rotacion(200,430,img0); 
}
  /**
    * Funcion donde definimos la ruta de las imagenes que usamos así como su tamaño
    * @param args sin usar.
    * @return Nada.
    */
void definirImagenes(){
  imgMaya= loadImage("imagenes/mayas.jpg");
  imgMaya.resize(1200,650);
  imgMaya2= loadImage("imagenes/mayas2.jpeg");
  imgMaya2.resize(1200,650);
  imgMaya3= loadImage("imagenes/mayas3.jpg");
  imgMaya3.resize(1200,650);
  imgSuma = loadImage("imagenes/suma.png");
  imgSuma.resize(30,30);
  imgResta = loadImage("imagenes/resta.png");
  imgResta.resize(30,30);
  imgMulti = loadImage("imagenes/multiplicacion.png");
  imgMulti.resize(30,30);
  imgDivi = loadImage("imagenes/division.png");
  
  
  
imgDivi.resize(30,30);
imgIgual = loadImage("imagenes/igual.png");
imgIgual.resize(50,30);
imgIgual2 = loadImage("imagenes/igual_rojo.png");
imgIgual2.resize(30,30);
imgBorrar = loadImage("imagenes/borrar.png");
imgBorrar.resize(50,30);

img0 = loadImage("imagenes/0.png");
img0.resize(30,30);
img1 = loadImage("imagenes/1.png");
//img1.resize(30,30);
img2 = loadImage("imagenes/2.png");
//img2.resize(30,30);
img3 = loadImage("imagenes/3.png");
//img3.resize(30,30);
img4 = loadImage("imagenes/4.png");
//img4.resize(30,30);
img5 = loadImage("imagenes/5.png");
img5.resize(30,30);
img6 = loadImage("imagenes/6.png");
img6.resize(30,30);
img7= loadImage("imagenes/7.png");
img7.resize(30,30);
img8 = loadImage("imagenes/8.png");
img8.resize(30,30);
img9 = loadImage("imagenes/9.png");
img9.resize(30,30);
img10 = loadImage("imagenes/10.png");
img10.resize(30,30);
img11 = loadImage("imagenes/11.png");
img11.resize(30,30);
img12 = loadImage("imagenes/12.png");
img12.resize(30,30);
img13 = loadImage("imagenes/13.png");
img13.resize(30,30);
img14 = loadImage("imagenes/14.png");
img14.resize(30,30);
img15 = loadImage("imagenes/15.png");
img15.resize(30,30);
img16 = loadImage("imagenes/16.png");
img16.resize(30,30);
img17 = loadImage("imagenes/17.png");
img17.resize(30,30);
img18 = loadImage("imagenes/18.png");
img18.resize(30,30);
img19 = loadImage("imagenes/19.png");
img19.resize(30,30);
}


  /**
    * Funcion donde se instancian los botones
    * @param args sin usar.
    * @return Nada.
    */
void definirBotones(){
  btn1 = new Button("1", 10, 50, 45, 30);
  btn2 = new Button("2", 60, 50, 45, 30);
  btn3 = new Button("3", 110, 50, 45, 30);
  btn4 = new Button("4",160, 50, 45, 30);
  btn5 = new Button("5",10, 130, 45, 30);
  btn6 = new Button("6",60, 130, 45, 30);
  btn7 = new Button("7",110, 130, 45, 30);
  btn8 = new Button("8",160, 130, 45, 30);
  btn9 = new Button("9",10, 210, 45, 30);
  btn10 = new Button("10",60, 210, 45, 30);
  btn11 = new Button("11",110,210, 45, 30);
  btn12 = new Button("12",160, 210, 45, 30);
  btn13 = new Button("13",10, 290, 45, 30);
  btn14 = new Button("14",60, 290, 45, 30);
  btn15 = new Button("15",110, 290, 45, 30);
  btn16 = new Button("16",160, 290, 45, 30);
  btn17 = new Button("17",10, 370, 45, 30);
  btn18 = new Button("18",60, 370, 45, 30);
  btn19 = new Button("19",110, 370, 45, 30);
   btn0 = new Button("0",160, 370, 45, 30);
   
   //OPERACIONES
   btnSuma = new Button("+",10, 480, 50, 30);
   btnResta= new Button("-",130, 480, 50, 30);
   btnMultiplicacion= new Button("X",10, 530, 50, 30);
   btnDivision = new Button("/",130,530, 50, 30);
   btnIgual = new Button("=",250,530, 50, 30);
   btnBorrar = new Button("Borrar",10,580, 70, 30);
   btnLimpiar= new Button("Limpiar",130,580, 70, 30);
   
}

  /**
    * Funciones donde se grafican los botones con la llamada del metodo Draw
    * @param args sin usar.
    * @return Nada.
    */
void dibujarBotones(){
btn0.Draw();
  btn1.Draw();
  btn2.Draw();
  btn3.Draw();
  btn4.Draw();
  btn5.Draw();
  btn6.Draw();
  btn7.Draw();
  btn8.Draw();
  btn9.Draw();
  btn10.Draw();
  btn11.Draw();
  btn12.Draw();
  btn13.Draw();
  btn14.Draw();
  btn15.Draw();
  btn16.Draw();
  btn17.Draw();
  btn18.Draw();
  btn19.Draw();
  //
  btnSuma.Draw();
  btnResta.Draw();
  btnMultiplicacion.Draw();
  btnDivision.Draw();
  btnBorrar.Draw();
  btnLimpiar.Draw();
  btnIgual.Draw();
}

  /**
    * Clase boton la cual usamos para crear botones
    * @param (texto, posicion en x, posicion en y, ancho del boton, alto del boton)
    * @return Nada.
    */
 class Button {
  String label; 
  float x;      
  float y;      
  float w;      
  float h;      
  // constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
   
  }
  //Funcion de la clase Button para cambiar el color de relleno
  void setFill(){
   fill(12,110,30,60); 
  }
  //Funcion de la clase Button para graficar el boton 
  void Draw() {
     fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
    /**
    * Funcion de la clase boton para saber si el puntero del mouse está por encima del boton
    * @param args sin usar.
    * @return variable booleana dependiendo si está encima o no del boton el puntero del mouse
    */
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}


  /**
    * Funcion que saca el valor total del 1er número ingresado
    * @param args sin usar.
    * @return Nada.
    */
void sacarValores1(){
  if(nivel==0){
   total=0; 
  }else if(nivel==1){
    total= valores1[0];
  }else if(nivel==2){
    total= valores1[1]+nivel2(valores1[0]); 
  }else if(nivel==3){
  total= valores1[2]+nivel2(valores1[1])+nivel3(valores1[0]);
  }else if(nivel==4){
  total= valores1[3]+nivel2(valores1[2])+nivel3(valores1[1])+nivel4(valores1[0]);
  }else if(nivel==5){
   total= valores1[4]+nivel2(valores1[3])+nivel3(valores1[2])+nivel4(valores1[1])+nivel5(valores1[0]);
  }
  
  tot1= ceil(total);
}
/**
    * Funcion que saca el valor del resultado de la operacion 
    * @param args sin usar.
    * @return Nada.
    */
void sacarValores3(){
  if(total3[0]==0&total3[1]==0&total3[2]==0&total3[3]==0&total3[4]==0&total3[5]==0){
   resultado=0; 
  }else if(nivel3==1){
  resultado= total3[5];
  }else if(nivel3==2){
  resultado= total3[5]+nivel2(total3[4]); 
  }else if(nivel3==3){
  resultado= total3[5]+nivel2(total3[4])+nivel3(total3[3]);
  }else if(nivel3==4){
  resultado= total3[5]+nivel2(total3[4])+nivel3(total3[3])+nivel4(total3[2]);
  }else if(nivel3==5){
   resultado= total3[5]+nivel2(total3[4])+nivel3(total3[3])+nivel4(total3[2])+nivel5(total3[1]);
  }else if(nivel3==6){
   resultado= total3[5]+nivel2(total3[4])+nivel3(total3[3])+nivel4(total3[2])+nivel5(total3[1])+nivel6(total3[0]);
  }
 // println(nivel3);
}

/**
    * Funcion que saca el valor total del 2do número ingresado
    * @param args sin usar.
    * @return Nada.
    */
void sacarValores2(){
  if(nivel2==0){
   total2=0; 
  }else if(nivel2==1){
    total2= valores2[0];
  }else if(nivel2==2){
    total2= valores2[1]+nivel2(valores2[0]); 
  }else if(nivel2==3){
  total2= valores2[2]+nivel2(valores2[1])+nivel3(valores2[0]);
  }else if(nivel2==4){
  total2= valores2[3]+nivel2(valores2[2])+nivel3(valores2[1])+nivel4(valores2[0]);
  }else if(nivel2==5){
   total2= valores2[4]+nivel2(valores2[3])+nivel3(valores2[2])+nivel4(valores2[1])+nivel5(valores2[0]);
  }
  tot2= ceil(total2);
}

/**
    * Funcion que muestra en pantalla el valor del 1er número ingresado
    * @param args sin usar.
    * @return Nada.
    */
void mostrarValores1(){
  fill(0);
  textSize(12);
  String valor1="";
  valor1+=total+"";
  text(valor1,320,345);
}
/**
    * Funcion que muestra en pantalla el valor del 2do número ingresado
    * @param args sin usar.
    * @return Nada.
    */
void mostrarValores2(){
  fill(0);
  textSize(12);
  String valor1="";
  valor1+=total2+"";
  text(valor1,465,345);
}
/**
    * Funcion que muestra en pantalla el valor del resultado de la operacion en pantalla
    * @param args sin usar.
    * @return Nada.
    */
void mostrarValores3(){
  fill(0);
  textSize(12);
  String valor1="";
  if(op=="multi"){
    valor1+=r2+"";
    text(valor1,620,396);
  }else
  if(nivel4>0){
    valor1+=resultadoR+"";
  }else{
  valor1+=resultado+"";
  }
  text(valor1,620,396);
 // print(resultado);
}

/**
    * Funcion que es llamada cuando se presiona y suelta un boton del mouse
    * @param args sin usar.
    * @return Nada.
    */
void mouseClicked() {
  seleccion();
  textSize(20);
  fill(255);
  BorrarLimpiar();
  Operaciones();
  //print(valores1[0]+""+valores1[1]+""+valores1[2]+""+valores1[3]+""+valores1[4]); 
  //print(nivel);
  hacerOperacion();
}

/**
    * Funcion que verifica que tipo de operacion se ha seleccionado
    * @param args sin usar.
    * @return Nada.
    */
void Operaciones(){
 if(nivel2==0&nivel>0){
  if(btnSuma.MouseIsOver()){
   if(nivel==0){
    msj=1;
   }else{
  operacion=true;
  op="suma";
   }
  
   
 } else if(btnResta.MouseIsOver()){
    if(nivel2==0){
   if(nivel==0){
     msj=1;
   }else{
   operacion=true;
  op="resta";
   }
    }
 }else if(btnMultiplicacion.MouseIsOver()){
    if(nivel2==0){
   if(nivel==0){
     msj=1;
   }else{
  operacion=true;
  op="multi";
   }
  
   }
 }else if(btnDivision.MouseIsOver()){
  if(nivel2==0){
   if(nivel==0){
     msj=1;
   }else{
   operacion=true;
  op="divi";
   }
   }
 }
}
if(btnIgual.MouseIsOver()&nivel>0&nivel2>0){
  
   
  operacion=true;
  op2="igual";
 }
}


/**
    * Funcion que va mostrando las imagenes de los valores que se van seleccionando del 1er número
    * @param args sin usar.
    * @return Nada.
    */
void mostrarImgValor1(){
  if(nivel==0){
    image(img0,300,50);
    image(img0,300,100);
    image(img0,300,150);
    image(img0,300,200);
    image(img0,300,250);
  }else if(nivel==1){
    num1= loadImage("imagenes/"+buscarValores1(valores1[0]) + ".png");
    image(img0,300,50);
    image(img0,300,100);
    image(img0,300,150);
    image(img0,300,200);
    num1.resize(30,30);
    image(num1,nivel11[0],nivel11[1]);
  }else if(nivel==2){
     num1= loadImage("imagenes/"+buscarValores1(valores1[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores1(valores1[1]) + ".png");
    image(img0,300,50);
    image(img0,300,100);
    image(img0,300,150);
    num1.resize(30,30);
    num2.resize(30,30);
    image(num1,nivel12[0],nivel12[1]); 
    image(num2,nivel11[0],nivel11[1]); 
  }else if(nivel==3){
     num1= loadImage("imagenes/"+buscarValores1(valores1[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores1(valores1[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores1(valores1[2]) + ".png");
    image(img0,300,50);
    image(img0,300,100);
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    image(num1,nivel13[0],nivel13[1]); 
    image(num2,nivel12[0],nivel12[1]); 
    image(num3,nivel11[0],nivel11[1]); 
  }else if(nivel==4){
     num1= loadImage("imagenes/"+buscarValores1(valores1[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores1(valores1[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores1(valores1[2]) + ".png");
     num4= loadImage("imagenes/"+buscarValores1(valores1[3]) + ".png");
    image(img0,300,50);
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    image(num1,nivel14[0],nivel14[1]); 
    image(num2,nivel13[0],nivel13[1]);
    image(num3,nivel12[0],nivel12[1]);
    image(num4,nivel11[0],nivel11[1]);
  }else if(nivel==5){
     num1= loadImage("imagenes/"+buscarValores1(valores1[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores1(valores1[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores1(valores1[2]) + ".png");
     num4= loadImage("imagenes/"+buscarValores1(valores1[3]) + ".png");
     num5= loadImage("imagenes/"+buscarValores1(valores1[4]) + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    image(num1,nivel15[0],nivel15[1]); 
    image(num2,nivel14[0],nivel14[1]); 
    image(num3,nivel13[0],nivel13[1]); 
    image(num4,nivel12[0],nivel12[1]); 
    image(num5,nivel11[0],nivel11[1]); 
  }
}

/**
    * Funcion que va mostrando las imagenes de los valores que se van seleccionando del 2do número
    * @param args sin usar.
    * @return Nada.
    */
void mostrarImgValor2(){
  if(nivel2==0){
    image(img0,450,50);
    image(img0,450,100);
    image(img0,450,150);
    image(img0,450,200);
    image(img0,450,250);
  }else if(nivel2==1){
    num1= loadImage("imagenes/"+buscarValores2(valores2[0]) + ".png");
    image(img0,450,50);
    image(img0,450,100);
    image(img0,450,150);
    image(img0,450,200);
    num1.resize(30,30);
    image(num1,nivel21[0],nivel21[1]);
  }else if(nivel2==2){
     num1= loadImage("imagenes/"+buscarValores2(valores2[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores2(valores2[1]) + ".png");
    image(img0,450,50);
    image(img0,450,100);
    image(img0,450,150);
    num1.resize(30,30);
    num2.resize(30,30);
    image(num1,nivel22[0],nivel22[1]); 
    image(num2,nivel21[0],nivel21[1]); 
  }else if(nivel2==3){
     num1= loadImage("imagenes/"+buscarValores2(valores2[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores2(valores2[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores2(valores2[2]) + ".png");
    image(img0,450,50);
    image(img0,450,100);
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    image(num1,nivel23[0],nivel23[1]); 
    image(num2,nivel22[0],nivel22[1]); 
    image(num3,nivel21[0],nivel21[1]); 
  }else if(nivel2==4){
     num1= loadImage("imagenes/"+buscarValores2(valores2[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores2(valores2[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores2(valores2[2]) + ".png");
     num4= loadImage("imagenes/"+buscarValores2(valores2[3]) + ".png");
    image(img0,450,50);
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    image(num1,nivel24[0],nivel24[1]); 
    image(num2,nivel23[0],nivel23[1]);
    image(num3,nivel22[0],nivel22[1]);
    image(num4,nivel21[0],nivel21[1]);
  }else if(nivel2==5){
     num1= loadImage("imagenes/"+buscarValores2(valores2[0]) + ".png");
     num2= loadImage("imagenes/"+buscarValores2(valores2[1]) + ".png");
     num3= loadImage("imagenes/"+buscarValores2(valores2[2]) + ".png");
     num4= loadImage("imagenes/"+buscarValores2(valores2[3]) + ".png");
     num5= loadImage("imagenes/"+buscarValores2(valores2[4]) + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    image(num1,nivel25[0],nivel25[1]); 
    image(num2,nivel24[0],nivel24[1]); 
    image(num3,nivel23[0],nivel23[1]); 
    image(num4,nivel22[0],nivel22[1]); 
    image(num5,nivel21[0],nivel21[1]); 
  }
}
/////////////////////////////////////
/**
    * Funcion que muestra las imagenes del resultado de la operacion
    * @param args sin usar.
    * @return Nada.
    */
void mostrarImgValor3(){
  //println(total3[0]+" "+total3[1]+" "+total3[2]+" "+total3[3]+" "+total3[4]+" "+total3[5]);
  //println(nivel3);
   if(nivel3==1){
    num1= loadImage("imagenes/"+total3[5] + ".png");
    
    num1.resize(30,30);
    image(num1,600,300);
  }else if(nivel3==2){
     num1= loadImage("imagenes/"+total3[5] + ".png");
     num2= loadImage("imagenes/"+total3[4] + ".png");
    
    num1.resize(30,30);
    num2.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
  }else if(nivel3==3){
     num1= loadImage("imagenes/"+total3[5] + ".png");
     num2= loadImage("imagenes/"+total3[4] + ".png");
     num3= loadImage("imagenes/"+total3[3] + ".png");
   
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
  }else if(nivel3==4){
     num1= loadImage("imagenes/"+total3[5] + ".png");
     num2= loadImage("imagenes/"+total3[4] + ".png");
     num3= loadImage("imagenes/"+total3[3] + ".png");
     num4= loadImage("imagenes/"+total3[2] + ".png");
    
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150);
  }else if(nivel3==5){
     num1= loadImage("imagenes/"+total3[5] + ".png");
     num2= loadImage("imagenes/"+total3[4] + ".png");
     num3= loadImage("imagenes/"+total3[3] + ".png");
     num4= loadImage("imagenes/"+total3[2] + ".png");
     num5= loadImage("imagenes/"+total3[1] + ".png");
    
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150); 
    image(num5,600,100); 
  }else if(nivel3==6){
     num1= loadImage("imagenes/"+total3[5] + ".png");
     num2= loadImage("imagenes/"+total3[4] + ".png");
     num3= loadImage("imagenes/"+total3[3] + ".png");
     num4= loadImage("imagenes/"+total3[2] + ".png");
     num5= loadImage("imagenes/"+total3[1] + ".png");
     num6= loadImage("imagenes/"+total3[0] + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    num6.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150); 
    image(num5,600,100); 
    image(num6,600,50); 
  }
  //println(total3[5]+" "+total3[4]+" "+total3[3]+" "+total3[2]+" "+total3[1]+" "+total3[0]+" ");
}

/////////////////////////////////////
/**
    * Funcion que muestra las imagenes de la operacion de resta
    * @param args sin usar.
    * @return Nada.
    */
void mostrarImgResta(){
  //println(total3[0]+" "+total3[1]+" "+total3[2]+" "+total3[3]+" "+total3[4]+" "+total3[5]);
  //println(nivel3);
  if(nivel4==1){
    num1= loadImage("imagenes/"+total4[5] + ".png");
    
    num1.resize(30,30);
    image(num1,600,300);
  }else if(nivel4==2){
     num1= loadImage("imagenes/"+total4[4] + ".png");
     num2= loadImage("imagenes/"+total4[5] + ".png");
    
    num1.resize(30,30);
    num2.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
  }else if(nivel4==3){
     num1= loadImage("imagenes/"+total4[3] + ".png");
     num2= loadImage("imagenes/"+total4[4] + ".png");
     num3= loadImage("imagenes/"+total4[5] + ".png");
  
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
  }else if(nivel4==4){
     num1= loadImage("imagenes/"+total4[2] + ".png");
     num2= loadImage("imagenes/"+total4[3] + ".png");
     num3= loadImage("imagenes/"+total4[4] + ".png");
     num4= loadImage("imagenes/"+total4[5] + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150);
  }else if(nivel4==5){
     num1= loadImage("imagenes/"+total4[1] + ".png");
     num2= loadImage("imagenes/"+total4[2] + ".png");
     num3= loadImage("imagenes/"+total4[3] + ".png");
     num4= loadImage("imagenes/"+total4[4] + ".png");
     num5= loadImage("imagenes/"+total4[5] + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150); 
    image(num5,600,100); 
  }else if(nivel4==6){
     num1= loadImage("imagenes/"+total4[0] + ".png");
     num2= loadImage("imagenes/"+total4[1] + ".png");
     num3= loadImage("imagenes/"+total4[2] + ".png");
     num4= loadImage("imagenes/"+total4[3] + ".png");
     num5= loadImage("imagenes/"+total4[4] + ".png");
     num6= loadImage("imagenes/"+total4[5] + ".png");
    num1.resize(30,30);
    num2.resize(30,30);
    num3.resize(30,30);
    num4.resize(30,30);
    num5.resize(30,30);
    num6.resize(30,30);
    image(num1,600,300);
    image(num2,600,250);
    image(num3,600,200);
    image(num4,600,150); 
    image(num5,600,100); 
    image(num6,600,50); 
  }
  //println(total3[5]+" "+total3[4]+" "+total3[3]+" "+total3[2]+" "+total3[1]+" "+total3[0]+" ");
}

///////////////////////////////////////////////////

int buscarValores1(int valor){
  int v=-1;
  //print(valor);
for(int i=-1; i<20;i++){
  if(valor==i){
  v=i;
  break;
  }
}
return v;
}
int buscarValores2(int valor){
  int v=-1;
  //print(valor);
for(int i=-1; i<20;i++){
  if(valor==i){
  v=i;
  break;
  }
}
return v;
}

/**
    * Funciones que llenan los arreglos con enteros
    * @param args sin usar.
    * @return Nada.
    */
void llenadoNivel1(){
   nivel11[0]=300;
   nivel11[1]=250;
   nivel12[0]=300;
   nivel12[1]=200;
   nivel13[0]=300;
   nivel13[1]=150;
   nivel14[0]=300;
   nivel14[1]=100;
   nivel15[0]=300;
   nivel15[1]=50;
}
void llenadoNivel2(){
   nivel21[0]=450;
   nivel21[1]=250;
   nivel22[0]=450;
   nivel22[1]=200;
   nivel23[0]=450;
   nivel23[1]=150;
   nivel24[0]=450;
   nivel24[1]=100;
   nivel25[0]=450;
   nivel25[1]=50;
}
void llenadoValores1(){
 valores1[0]=-1; 
 valores1[1]=-1; 
 valores1[2]=-1; 
 valores1[3]=-1; 
 valores1[4]=-1; 
}
void llenadoValores2(){
 valores2[0]=-1; 
 valores2[1]=-1; 
 valores2[2]=-1; 
 valores2[3]=-1; 
 valores2[4]=-1; 
}

/**
    * Funcion para verificar si se usa el boton limpiar o borrar y reiniciar ciertas variables y arreglos
    * @param args sin usar.
    * @return Nada.
    */
void BorrarLimpiar(){
  if(op2==""){
  if(btnBorrar.MouseIsOver()){ 
    if(operacion==false){
    valores1[0]=-1;
    valores1[1]=-1;
    valores1[2]=-1;
    valores1[3]=-1;
    valores1[4]=-1;
    nivel=0;
    msj=0;
    }else{
    valores2[0]=-1;
    valores2[1]=-1;
    valores2[2]=-1;
    valores2[3]=-1;
    valores2[4]=-1;
    nivel2=0;
    msj=0;
    }
   // print("Borrar\n");
  }
  }
  if(btnLimpiar.MouseIsOver()||msj==3){
  operacion=false;
  op="";
  op2="";
  msj=0;
  valores1[0]=-1;
    valores1[1]=-1;
    valores1[2]=-1;
    valores1[3]=-1;
    valores1[4]=-1;
    nivel=0;
    nivel2=0;
    nivel3=0;
    nivel4=0;
    total=0;
    r=0;
    r2=0;
    total3[0]=0;
    total3[1]=0;
    total3[2]=0;
    total3[3]=0;
    total3[4]=0;
    total3[5]=0;
    total4[0]=0;
    total4[1]=0;
    total4[2]=0;
    total4[3]=0;
    total4[4]=0;
    valores2[0]=-1;
    valores2[1]=-1;
    valores2[2]=-1;
    valores2[3]=-1;
    valores2[4]=-1;
   // print("Limpiar\n");
}
}



/**
    * Funcion que compara cuál operacion fue seleccionada para mostrar la imagen de dicha operacion
    * @param args sin usar.
    * @return Nada.
    */
void ImagenOperacion(){
 if(op.equals("")){
 }else if(op.equals("suma")){
   image(imgSuma,375,150);
 }else if(op.equals("resta")){
   image(imgResta,375,150);
 }else if(op.equals("multi")){
   image(imgMulti,375,150);
 }else if(op.equals("divi")){
   image(imgDivi,375,150);
 }
}


/**
    * Funciones para mostrar un mensaje dependiendo del error que haya
    * @param args sin usar.
    * @return Nada.
    */
void MsjNumeroAntesDeCero(){
  fill(250);
  textSize(16);
  text("Debes ingresar un numero antes del cero",500,450);
}
void MsjNumeroAntesDeOperacion(){
    fill(250);
  textSize(16);
  text("Debes ingresar un numero antes de la operacion",500,450);
}
void MsjResultadoNegativo(){
  fill(250);
  textSize(16);
  text("                      En la simbología maya no existen numeros negativos \n intenta con otros numeros",500,450);
}

void MsjElegirOperador(){
fill(250);
  textSize(16);
  text("Debes elegir un tipo de operacion antes de ingresar el número 2",500,450);
}
void MsjResultadoGrande(){
fill(250);
  textSize(16);
  text("El resultado máximo es 63999999, escoge otros números por favor :D",500,450);
}
void MsjDivisionTruncada(){
fill(250);
  textSize(16);
  text("Los decimales no están representados en Maya",500,450);
}

/**
    * Funcion que verifica que mensaje de error hay para mostrar el mensaje
    * @param args sin usar.
    * @return Nada.
    */
void MostrarMsj()
{
 if(msj==1){
   MsjNumeroAntesDeOperacion();
 }else if(msj==2){
   MsjNumeroAntesDeCero();
 }else if(msj==3){
   MsjResultadoNegativo();
 }else if(msj==4){
   MsjElegirOperador();
 }else if(msj==5){
   MsjResultadoGrande();
 }else if(msj==6){
   MsjDivisionTruncada();
 }
 
}

/**
    * Funcion para hacer la operacion seleccionada, solo si ya se han ingresado dos valores y se presionó la tecla igual
    * @param args sin usar.
    * @return Nada.
    */
void hacerOperacion(){
 // println(op+"   "+op2);
 // println(nivel+"  "+nivel2);
  if(op2=="igual"&nivel>0&nivel2>0){
   if(op=="suma"){
   //  print("igualSuma");
    total3= Suma(valores1,valores2);
     // println("\n0: "+total3[0]+"\n1: "+total3[1]+"\n2: "+total3[2]+"\n3: "+total3[3]+" \n4: "+total3[4]+" \n5:"+total3[5]);
   }else if(op=="resta"){
    
     r=Resta();
     if(r<0){
      msj=3; 
     }else{
       total4= convertirDecAArreglo(r);
       resultadoR=r;
       //println("\n0: "+total4[0]+"\n1: "+total4[1]+"\n2: "+total4[2]+"\n3: "+total4[3]+" \n4: "+total4[4]+" \n5:"+total4[5]);
       //println("Nivel: "+nivel4);
      // println("R= "+r);
     }
   }else if(op=="multi"){
     r2=Multiplicacion();
    // println(r2);
    // print(total2);
    // println("\n0: "+total4[0]+"\n1: "+total3[1]+"\n2: "+total3[2]+"\n3: "+total3[3]+" \n4: "+total3[4]+" \n5:"+total3[5]);
     if(r2<=63999999){
       total4=convertirDecAArreglo2(r2);
      //println("\n0: "+total4[0]+"\n1: "+total3[1]+"\n2: "+total3[2]+"\n3: "+total3[3]+" \n4: "+total3[4]+" \n5:"+total3[5]);
      //println("\n0: "+total4[0]+"\n1: "+total4[1]+"\n2: "+total4[2]+"\n3: "+total4[3]+" \n4: "+total4[4]+" \n5:"+total4[5]);
       resultadoR=r;
     
     //  println("Nivel: "+nivel4);
     }else{
       msj=5;
     }
   }else if(op=="divi"){
     r=Division();
     total4=convertirDecAArreglo(r);
     msj=6;
     resultadoR=r;
   }
   
  }
}///////////////////////// end hacerOperacion()

/////////////////////////////////////////////////////////////////////////////////////////// RESTA
/**
    * Funcion que realiza la operacion de resta entre los dos numeros ingresados
    * @param args sin usar.
    * @return resultado de tipo flotante
    */
 float Resta(){
 float r=0;
 r= (total-total2);
 
 return r;
}
/////////////////////////////////////////////////////////////////////////////////////////// MULTIPLICACION
/**
    * Funcion que realiza la operacion de multiplicacion entre los dos numeros ingresados
    * @param args sin usar.
    * @return resultado de tipo flotante
    */
int Multiplicacion(){
 int r=0;
 r= (tot1*tot2);
// print(tot1+ "     "+ tot2);
 return r;
}
/////////////////////////////////////////////////////////////////////////////////////////// DIVISION
/**
    * Funcion que realiza la operacion de division entre los dos numeros ingresados
    * @param args sin usar.
    * @return resultado de tipo flotante
    */
float Division(){
 float r=0;
 r= total/total2;
 
 return r;
}


/////////////////////////////////////////////////////////////////////////////////////////// SUMA
/**
    * Funcion que verifica si los valores son mayores a 20 para hacer un corrimiento de valor a la siguiente posicion, (ya que en maya se usa hasta el 19 por posicion)
    * @param args (arreglo de numeros enteros, arreglo de numeros enteros)
    * @return resultado en un arreglo unidimensional de tipo entero
    */
int[] Suma(int[] v1, int[] v2){
  int [] t= new int[6];
  t= sumaArreglos(v1,v2);
  if(t[5]<0){
    t[5]=0;
  }
  if(t[0]<0){
    t[0]=0;
  }
  if(t[4]<0){
    t[4]=0;
  }
  if(t[3]<0){
    t[3]=0;
  }
  if(t[2]<0){
    t[2]=0;
  }
  if(t[1]<0){
    t[1]=0;
  }
  for(;;){
    
    if(t[0]<20&t[1]<20&t[2]<20&t[3]<20&t[4]<20&t[5]<20){
      break;
    }else{
      if(nivel3==1){//////////// lvl1
       if(t[5]>=20){
         t[4]= t[4]+1;
         t[5]= t[5]-20;
         nivel3=2;
       }
      }else if(nivel3==2){//////////// lvl2
        if(t[5]>=20){
         t[4]=t[4]+1;
         t[5]=t[5]-20;
       }
        if(t[4]>=20){
         t[4]=t[4]-20;
         t[3]= t[3]+1;
         
         nivel3=3;
       }
       }else if(nivel3==3){//////////// lvl3
          if(t[5]>=20){
         t[5]=t[5]-20;
         t[4]=t[4]+1;
       }
        if(t[4]>=20){
         t[4]=t[4]-20;
         t[3]=t[3]+1;
       }
       if(t[3]>=20){
         t[3]=t[3]-20;
         t[2]= t[2]+1;
         nivel3=4;
       }
       }else if(nivel3==4){//////////// lvl4
          if(t[5]>=20){
         t[5]=t[5]-20;
         t[4]=t[4]+1;
       }
        if(t[4]>=20){
         t[4]=t[4]-20;
         t[3]=t[3]+1;
       }
       if(t[3]>=20){
         t[3]=t[3]-20;
         t[2]=t[2]+1;
       }
       if(t[2]>=20){
         t[2]=t[2]-20;
         t[1]= t[1]+1;
         nivel3=5;
       }
       }else if(nivel3==5){//////////// lvl5
          if(t[5]>=20){
         t[5]=t[5]-20;
         t[4]=t[4]+1;
       }
        if(t[4]>=20){
         t[4]=t[4]-20;
         t[3]=t[3]+1;
       }
       if(t[3]>=20){
         t[3]=t[3]-20;
         t[2]=t[2]+1;
       }
       if(t[2]>=20){
         t[2]=t[2]-20;
         t[1]=t[1]+1;
       }
       if(t[1]>=20){
         t[1]=t[1]-20;
         t[0]= t[0]+1;
         nivel3=6;
       }
    }
  }
      }
  return t;
}

/**
    * Funcion que realiza la operacion de suma entre los valores de dos arreglos de tipo entero y lo guarda en otro arreglo
    * @param (arreglo de tipo entero, arreglo de tipo entero)
    * @return arreglo de tipo entero
    */

int[] sumaArreglos(int[] v1, int[] v2){
  int[] t2= new int[6];
 if(nivel==1&nivel2==1){
  t2[5]= v1[0]+v2[0];
  nivel3=1;
  print("1");
 }else if(nivel==2&nivel2==2){
  t2[4]= v1[0]+v2[0];
  t2[5]= v1[1]+v2[1];
  nivel3=2;
 }else if(nivel==3&nivel2==3){
  t2[3]= v1[0]+v2[0];
  t2[4]= v1[1]+v2[1];
  t2[5]= v1[2]+v2[2]; 
  nivel3=3;
 }else if(nivel==4&nivel2==4){
  t2[2]= v1[0]+v2[0];
  t2[3]= v1[1]+v2[1];
  t2[4]= v1[2]+v2[2];
  t2[5]= v1[3]+v2[3]; 
  nivel3=4;
 }else if(nivel==5&nivel2==5){////////////////// Sumas iguales
  t2[1]= v1[0]+v2[0];
  t2[2]= v1[1]+v2[1];
  t2[3]= v1[2]+v2[2];
  t2[4]= v1[3]+v2[3];
  t2[5]= v1[4]+v2[4]; 
  nivel3=5;
 }else if(nivel==2&nivel2==1){
   t2[4]= v1[0];
   t2[5]= v1[1]+v2[0];
   nivel3=2;
 }else if(nivel==3&nivel2==1){
   t2[3]= v1[0];
   t2[4]= v1[1];
   t2[5]= v1[2]+v2[0];
   nivel3=3;
 }else if(nivel==4&nivel2==1){
   t2[2]= v1[0];
   t2[3]= v1[1];
   t2[4]= v1[2];
   t2[5]= v1[3]+v2[0];
   nivel3=4;
 }else if(nivel==5&nivel2==1){ /////// 1++, 2=1
   t2[1]= v1[0];
   t2[2]= v1[1];
   t2[3]= v1[2];
   t2[4]= v1[3];
   t2[5]= v1[4]+v2[0];
   nivel3=5;
    }else if(nivel==2&nivel2==3){
   t2[3]=      v2[0];
   t2[4]= v1[0]+v2[1];
   t2[5]= v1[1]+v2[2];
   nivel3=3;
   }else if(nivel==2&nivel2==4){
   t2[2]=       v2[0];
   t2[3]=       v2[1];
   t2[4]= v1[0]+v2[2];
   t2[5]= v1[1]+v2[3];
   nivel3=4;
   }else if(nivel==2&nivel2==5){
   t2[1]=       v2[0];
   t2[2]=       v2[1];
   t2[3]=       v2[2];
   t2[4]= v1[0]+v2[3];
   t2[5]= v1[1]+v2[4];
   nivel3=5;
   }else if(nivel==3&nivel2==5){
   t2[1]=       v2[0];
   t2[2]=       v2[1];
   t2[3]= v1[0]+v2[2];
   t2[4]= v1[1]+v2[3];
   t2[5]= v1[2]+v2[4];
   nivel3=5;
   }else if(nivel==3&nivel2==2){
        
   t2[3]= v1[0];
   t2[4]= v1[1]+v2[0];
   t2[5]= v1[2]+v2[1];
   nivel3=3;
 }else if(nivel==3&nivel2==4){
   t2[2]=       v2[0];
   t2[3]= v1[0]+v2[1];
   t2[4]= v1[1]+v2[2];
   t2[5]= v1[2]+v2[3];
   nivel3=4;
 }else if(nivel==4&nivel2==2){
   t2[2]= v1[0];
   t2[3]= v1[1];
   t2[4]= v1[2]+v2[0];
   t2[5]= v1[3]+v2[1];
   nivel3=4;
 }else if(nivel==4&nivel2==3){/////////////////
   t2[2]= v1[0];
   t2[3]= v1[1]+v2[0];
   t2[4]= v1[2]+v2[1];
   t2[5]= v1[3]+v2[2];
   nivel3=4;
    }else if(nivel==5&nivel2==2){
   t2[1]= v1[0];
   t2[2]= v1[1];
   t2[3]= v1[2];
   t2[4]= v1[3]+v2[0];
   t2[5]= v1[4]+v2[1];
   nivel3=5;
   }else if(nivel==5&nivel2==3){
   t2[1]= v1[0];
   t2[2]= v1[1];
   t2[3]= v1[2];
   t2[4]= v1[3]+v2[0];
   t2[4]= v1[3]+v2[1];
   t2[5]= v1[4]+v2[2];
   nivel3=5;
   }else if(nivel==5&nivel2==4){
   t2[1]= v1[0];
   t2[2]= v1[1];
   t2[3]= v1[2]+v2[0];
   t2[4]= v1[3]+v2[1];
   t2[4]= v1[3]+v2[2];
   t2[5]= v1[4]+v2[3];
   nivel3=5;
    }else if(nivel==4&nivel2==3){
   t2[1]= v1[0];
   t2[2]= v1[0];
   t2[3]= v1[1]+v2[0];
   t2[4]= v1[2]+v2[1];
   t2[5]= v1[3]+v2[2];
   nivel3=4;
    }else if(nivel==4&nivel2==4){
   t2[1]= v1[0];
   t2[2]= v1[0]+v2[0];
   t2[3]= v1[1]+v2[1];
   t2[4]= v1[2]+v2[2];
   t2[5]= v1[3]+v2[3];
   nivel3=4;
   }else if(nivel==4&nivel2==5){
   t2[1]=       v2[0];
   t2[2]= v1[0]+v2[1];
   t2[3]= v1[1]+v2[2];
   t2[4]= v1[2]+v2[3];
   t2[5]= v1[3]+v2[4];
   nivel3=5;
 }else if(nivel==1&nivel2==2){//////////////////////  lvl2
   t2[4]= v2[0];
   t2[5]= v2[1]+v1[0];
   nivel3=2;
 }else if(nivel==1&nivel2==3){
   t2[3]= v2[0];
   t2[4]= v2[1];
   t2[5]= v2[2]+v1[0];
   nivel3=3;
 }else if(nivel==1&nivel2==4){
   t2[2]= v2[0];
   t2[3]= v2[1];
   t2[4]= v2[2];
   t2[5]= v2[3]+v1[0];
   nivel3=4;
 }else if(nivel==1&nivel2==5){
   t2[1]= v2[0];
   t2[2]= v2[1];
   t2[3]= v2[2];
   t2[4]= v2[3];
   t2[5]= v2[4]+v1[0];
   nivel3=5;
 }
  
  return t2;
}
/**
    * Funcion para convertir una variable decimal a base 20 (la numerología de los mayas)
    * @param (resultado de tipo flotante)
    * @return arreglo de tipo entero
    */
int[] convertirDecAArreglo(float res){
  int t[]= new int[6];
  int r= (int) res;
  int c6=0,c5=0,c4=0,c3=0,c2=0,c1=0;
  if(r>=3200000&r<64000000){
    for(;;){
      if(r>=3200000){
          t[5]=t[5]+1;
          r=r-3200000;
          
      }else{
          break;  
      }
    }
            c6++;
            nivel4=6;
  }
  if(r>=160000&r<=3200000){
    for(;;){
      if(r>=160000){
        if(c6==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        } 
        r=r-160000;
      }else{
          break;  
      }
    }
          if(c6==1){
            
          }else{
            
           c5++;
           nivel4=5; 
          }
  }
  if(r>=8000&r<160000){
    for(;;){
      if(r>=8000){
        if(c6==1){
          t[3]=t[3]+1;
        }else if(c5==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-8000;
      }else{
          break;  
      }
    }
    if(c5==1||c6==1){
            
          }else{
            
           c4++;
           nivel4=4; 
          }
  }
  if(r>=400&r<8000){
    for(;;){
      if(r>=400){
        if(c6==1){
          t[2]=t[2]+1;
        }else if(c5==1){
          t[3]=t[3]+1;
        }else if(c4==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-400;
      }else{
          break;  
      }
    }
    if(c4==1||c5==1||c6==1){
            
          }else{
           nivel4=3; 
           c3++;
          }
  }
  if(r>=20&r<400){
    for(;;){
      if(r>=20){
          if(c6==1){
          t[1]=t[1]+1;
        }else if(c5==1){
          t[2]=t[2]+1;
        }else if(c4==1){
          t[3]=t[3]+1;
        }else if(c3==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-20;
          
          
      }else{
          break;  
      }
    }
    if(c3==1||c4==1||c5==1||c6==1){
            
          }else{
           nivel4=2; 
           c2++;
          }
  }
  if(r<=19){
          if(c6==1){
             t[0]=r;
          } else if(c5==1){
             t[1]=r;
          }else if(c4==1){
             t[2]=r;
          }else if(c3==1){
             t[3]=r;
          }else if(c2==1){
             t[4]=r;
          }else{
             t[5]=r;
          }
          r=r-r;
          if(c2==1||c3==1||c4==1||c5==1||c6==1){
            
          }else{
           nivel4=1; 
          }
  }
  
  return t;
}

int[] convertirDecAArreglo2(int res){
  int t[]= new int[6];
  int r= res;
  int c6=0,c5=0,c4=0,c3=0,c2=0,c1=0;
  if(r>=3200000&r<64000000){
    for(;;){
      if(r>=3200000){
          t[5]=t[5]+1;
          r=r-3200000;
          
      }else{
          break;  
      }
    }
            c6++;
            nivel4=6;
  }
  if(r>=160000&r<=3200000){
    for(;;){
      if(r>=160000){
        if(c6==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        } 
        r=r-160000;
      }else{
          break;  
      }
    }
          if(c6==1){
            
          }else{
            
           c5++;
           nivel4=5; 
          }
  }
  if(r>=8000&r<160000){
    for(;;){
      if(r>=8000){
        if(c6==1){
          t[3]=t[3]+1;
        }else if(c5==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-8000;
      }else{
          break;  
      }
    }
    if(c5==1||c6==1){
            
          }else{
            
           c4++;
           nivel4=4; 
          }
  }
  if(r>=400&r<8000){
    for(;;){
      if(r>=400){
        if(c6==1){
          t[2]=t[2]+1;
        }else if(c5==1){
          t[3]=t[3]+1;
        }else if(c4==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-400;
      }else{
          break;  
      }
    }
    if(c4==1||c5==1||c6==1){
            
          }else{
           nivel4=3; 
           c3++;
          }
  }
  if(r>=20&r<400){
    for(;;){
      if(r>=20){
          if(c6==1){
          t[1]=t[1]+1;
        }else if(c5==1){
          t[2]=t[2]+1;
        }else if(c4==1){
          t[3]=t[3]+1;
        }else if(c3==1){
          t[4]=t[4]+1;
        }else{
          t[5]=t[5]+1;
        }
          r=r-20;
          
          
      }else{
          break;  
      }
    }
    if(c3==1||c4==1||c5==1||c6==1){
            
          }else{
           nivel4=2; 
           c2++;
          }
  }
  if(r<=19){
          if(c6==1){
             t[0]=r;
          } else if(c5==1){
             t[1]=r;
          }else if(c4==1){
             t[2]=r;
          }else if(c3==1){
             t[3]=r;
          }else if(c2==1){
             t[4]=r;
          }else{
             t[5]=r;
          }
          r=r-r;
          if(c2==1||c3==1||c4==1||c5==1||c6==1){
            
          }else{
           nivel4=1; 
          }
  }
  
  return t;
}

/**
    * Funcion para cargar el arreglo de shaders
    * @param args sin usar.
    * @return Nada
    */
void setupShader() 
{
  shade = loadShader(shaders[idxShader]);

  
}

/**
    * Funcion que modifica caracteristicas del shader seleccionado mediante el movimiento del puntero del mouse en el eje X y Y
    * @param args sin usar.
    * @return Nada
    */
void setShaderParameters() 
{

  if (idxShader == 0) {
    shade.set("brightness", 1.0);
    shade.set("contrast", map(mouseX, 0, width, -5, 5));
    shade.set("saturation", map(mouseY, 0, height, -5, 5));
  }

 
  else if (idxShader == 1) {
    shade.set("hue", map(mouseX, 0, width, 0, TWO_PI));
  } 

 
  else if (idxShader == 2) {
    shade.set("pixels", 0.1 * mouseX, 0.1 * mouseY);
  } 

  
  else if (idxShader == 3) {
    shade.set("sigma", map(mouseX, 0, width, 0, 10.0));
    shade.set("blurSize", (int) map(mouseY, 0, height, 0, 30.0));
    shade.set("texOffset", 1.0, 1.0);
  } 

  
  else if (idxShader == 4) {
    shade.set("rbias", 0.0, 0.0);
    shade.set("gbias", map(mouseY, 0, height, -0.2, 0.2), 0.0);
    shade.set("bbias", 0.0, 0.0);
    shade.set("rmult", map(mouseX, 0, width, 0.8, 1.5), 1.0);
    shade.set("gmult", 1.0, 1.0);
    shade.set("bmult", 1.0, 1.0);
  } 
  
  
  else if (idxShader == 5) {
    shade.set("threshold", map(mouseX, 0, width, 0, 1));
  } 

  
  else if (idxShader == 6) {
    shade.set("brt", map(mouseX, 0, width, 0, 0.5));
    shade.set("rad", (int) map(mouseY, 0, height, 0, 3));
  } 

  
  else if (idxShader == 7) {
  }
    
 // wrap
  else if (idxShader == 8) {
    shade.set("radius", map(mouseX, 0, width, 0, 2));
    shade.set("radTwist", map(mouseY, 0, height, 1.0, 10));
  }

  
  else if (idxShader == 9) {
    shade.set("time", (float) millis()/1000.0);
    shade.set("mouse", (float) mouseX/width, (float) mouseY/height);
    shade.set("turns", map(sin(0.01*frameCount), -1, 1, 2.0, 10.0));
  }

  
  else if (idxShader == 10) {
    shade.set("time", (float) millis()/1000.0);
    shade.set("pixels", mouseX/5, 250.0);
    shade.set("rollRate", map(mouseY, 0, height, 0, 10.0));
    shade.set("rollAmount", 0.25);
  }

  
  else if (idxShader == 11) {
    shade.set("row", map(mouseX, 0, width, 0, 1));
    shade.set("col", map(mouseY, 0, height, 0, 1));
  }

  
  else if (idxShader == 12) {
    shade.set("modr", map(mouseX, 0, width, 0, 0.5));
    shade.set("modg", 0.3);
    shade.set("modb", map(mouseY, 0, height, 0, 0.5));
  }

  
  else if (idxShader == 13) {
    shade.set("pixelsPerRow", (int) map(mouseX, 0, width, 2, 100));
  }
  
  
  else if (idxShader == 14) {
    shade.set("density", map(mouseX, 0, width, 0, 1));
    shade.set("frequency", map(mouseY, 0, height, 0, 100));
  }

  
  else if (idxShader == 15) {
  }

 
  else if (idxShader == 16) {
    shade.set("resolution", float(width), float(height));
    shade.set("sigma", 20*pow(map(mouseX, 0, width, 0, 1),2));
  }    
}


/**
    * Funcion que es llamada cuando se presiona alguna tecla y compara las flechas; arriba, abajo, derecha e izquierda..
    * @param args sin usar.
    * @return Nada
    */
void keyPressed() {
  if      (keyCode==LEFT) {
    idxShader = (idxShader + shaders.length - 1) % shaders.length;
    setupShader();
  }    
  else if (keyCode==RIGHT) {
    idxShader = (idxShader + 1) % shaders.length;
    setupShader();
  }
  
  if (keyCode==UP) {
    if(idxSource==2){
      idxSource=0;
    }else{
    idxSource = (idxSource + 1) ;
    }
  }
  else if (keyCode==DOWN) {
     idxSource = (idxSource - 1);
     if(idxSource<0){
       idxSource=2;
     }
  }
}

/**
    * Funcion que realiza la operacion de resta entre los dos numeros ingresados
    * @param (valor entero para X, valor entero para Y, un objeto de tipo imagen)
    * @return Nada
    */

void Rotacion(int x, int y, PImage img){
  pushMatrix();
  noStroke();
  translate(x, y, 0);
  rotateX(mouseY*.05);
  rotateY(mouseX*.05);
  scale(12);
  TexturedCube(img);
  popMatrix();
}

/**
    * Funcion que realiza la operacion de resta entre los dos numeros ingresados
    * @param (objeto de tipo imagen)
    * @return Nada
    */
void TexturedCube(PImage tex) {
  beginShape(QUADS);
  texture(tex);
  // X cara adelante
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

  // -Z cara atras
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

  // +Y cara abajo
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  // -Y cara arriba
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);

  // +X cara der
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  // -X cara izq
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  endShape();
}
