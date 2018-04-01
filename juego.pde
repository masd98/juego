/*---------var pantalla----------
 0. home
 1. nivel1
 2. nivel2
 3. nivel3
 4. creador
 5. game over
 */
int pantalla;

//-------bloque configuracion---------

void setup() {
  size(500, 500);
}

//---------bloque dibujo-------------
void draw() {
  //contenido dependiendo de "pantalla"
  if (pantalla==0) {
    home();
  } else if (pantalla==1) {
    nivel1();
  } else if (pantalla==2) {
    nivel2();
  } else if (pantalla==3) {
    nivel3();
  } else if (pantalla==4) {
    creador();
  } else if (pantalla==5) {
    gameover();
  }
}


//------contenido pantalla------------

void home() {
  background(255);

  textAlign(CENTER);
  fill(153, 0, 153);
  textSize(70);
  text("Juego Euclid", width/2, height/4);
  textSize(25);
  fill(153, 0, 76);
  text("Nivel 1", width/2, height*4/8);
  text("Nivel 2", width/2, height*5/8);
  text("Nivel 3", width/2, height*6/8);
  text("Creador", width/2, height*7/8);

  if (mousePressed) {
    if (mouseY>height*4/8-20&&mouseY<height*4/8+20) {
      pantalla=1;
    } else if (mouseY>height*5/8-20&&mouseY<height*5/8+20) {
      pantalla=2;
    } else if (mouseY>height*6/8-20&&mouseY<height*6/8+20) {
      pantalla=3;
    } else if (mouseY>height*7/8-20&&mouseY<height*7/8+20) {
      pantalla=4;
    }
  }
}
//matrices y tablas principales
Table u_puntos;
int contador[][]=new int[9][9];
Table conex;

int aux;
void nivel1() {
  background(229, 204, 255);

  //carga de tabla para el nivel
  u_puntos= loadTable("nivel1.1.csv");
  conex= loadTable("nivel1.2.csv");

  contador();
  strokeWeight(5);
  stroke(174, 163, 176);
  esqueleto();

  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (u_puntos.getInt(j, i)==1) {
        stroke(145, 47, 86);
        strokeWeight(15);
        point(i*50+50, j*50+50);
      }
    }
  }
  strokeWeight(2);
  stroke(140, 28, 19);

  dibujo();
  reglas();
}


void nivel2() {
  background(204, 229, 255);
  u_puntos= loadTable("nivel2.1.csv");
  conex= loadTable("nivel2.2.csv");

  contador();
  strokeWeight(5);
  stroke(192, 197, 193);
  esqueleto();

  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (u_puntos.getInt(j, i)==1) {
        stroke(87, 75, 96);
        strokeWeight(15);
        point(i*50+50, j*50+50);
      }
    }
  }
  strokeWeight(2);
  stroke(63, 51, 77);

  dibujo();
  reglas();
}


void nivel3() {
  background(255, 204, 204);
  u_puntos= loadTable("nivel3.1.csv");
  conex= loadTable("nivel3.2.csv");

  contador();
  strokeWeight(5);
  stroke(185, 186, 163);
  esqueleto();

  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (u_puntos.getInt(j, i)==1) {
        stroke(10, 16, 13);
        strokeWeight(15);
        point(i*50+50, j*50+50);
      }
    }
  }
  strokeWeight(2);
  stroke(162, 44, 41);

  dibujo();
  reglas();
}

void creador() {
  background(204, 255, 204);  
  fill(245);
  rect( 0, height*3/8, width, height/4, 7);
  textAlign(CENTER);

  fill(150, 150, 255);
  textSize(25);
  text("Esta funcion aun no esta disponible", width/2, height/2);
}
int game;
void gameover() {
  if (game==0) {
    background(0, 0, 0);
    textAlign(CENTER);
    fill(153, 255, 153);
    textSize(70);
    text("Ganaste", width/2, height/2);
    if (mousePressed) {
      exit();
    }
  } else if (game==1) {
    background(0, 0, 0);
    textAlign(CENTER);
    fill(153, 255, 153);
    textSize(70);
    text("perdiste", width/2, height/2);
    if (mousePressed) {
      exit();
    }
  }
}
//--------voids aux-------------

/*
 1. esqueleto : este void crea las lineas con las relas de conex
 2. contador: pone un valor unico a cada punto y linea
 3. dibujo: da las normas para dibujar lineas
 */
int reglas;
void reglas() {
  if (reglas!=2) {
    fill(245);
    rect( 0, height*3/8, width, height/4, 7);
    textAlign(CENTER);

    fill(150, 150, 255);
    textSize(25);
    text("Completa el camino sin \n repetir ninguna linea", width/2, height/2);
  }
}
int aux1, aux2;
int state;

/*1*/void esqueleto() {
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) { 
      if (contador[i][j]!=0) {
        aux1=contador[i][j]; 
        for (int m = 0; m < 9; m++) {
          for (int n = 0; n < 9; n++) { 
            if (contador[m][n]!=0) {
              aux2=contador[m][n]; 
              //println(aux1, " ", aux2, " ", conex.getInt(aux1-1, aux2-1)); //autentificacion
              if (conex.getInt(aux1-1, aux2-1)!=0) {
                line(i*50+50, j*50+50, m*50+50, n*50+50);
              }
            }
          }
        }
      }
    }
  }
}

int stop;
int c_lineas[][]=new int[2][100];

int aux_lineas;
int cont_lineas;
/*2*/void contador() {
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) { 
      if (u_puntos.getInt(j, i)==1&&contador[i][j]==0) {
        contador[i][j]=aux+1;
        aux=contador[i][j];
        println(aux, i, j);
      }
    }
  }

  if (stop==0) {
    for (int i = 0; i < aux; i++) {
      for (int j = 0; j < aux; j++) { 
        if (conex.getInt(i, j)!=0) {
          if (cont_lineas<49) {
            c_lineas[0][cont_lineas]=i;
            c_lineas[1][cont_lineas]=j;
            cont_lineas=cont_lineas+1;
            //println(cont_lineas);
          }
        }
      }
    }
  }
  stop=1;
}

int arr_lineas[]=new int[100];
int c1, c2, c3, c4;


void dibujo() {
  if (b!=0&&c!=0) {

    for (int i=0; i<cont_lineas; i++) {      
      if (c_lineas[0][i]==b-1&&c_lineas[1][i]==c-1) {
        if (arr_lineas[i]==0) {
          //println(b-1, " ", c-1, " ", arr_lineas[i]);
          arr_lineas[i]=1;
          //println(b-1, " ", c-1, " ", i, arr_lineas[i]);
        }
      }
      if (c_lineas[0][i]==c-1&&c_lineas[1][i]==b-1) {
        if (arr_lineas[i]==0) {
          //println(c-1, " ", b-1, " ", arr_lineas[i]);
          arr_lineas[i]=1;
          //println(c-1, " ", b-1, " ", i, arr_lineas[i]);
        }
      }
    }
  }

  for (int i=0; i<49; i++) {
    if (arr_lineas[i]==1) {
      for (int m=0; m<9; m++) {
        for (int n=0; n<9; n++) {
          if (contador[m][n]==c_lineas[0][i]+1) {
            c1=m; 
            c2=n;
          }
        }
      }
      for (int m=0; m<9; m++) {
        for (int n=0; n<9; n++) {
          if (contador[m][n]==c_lineas[1][i]+1) {
            c3=m; 
            c4=n;
          }
        }
      }
      line(c1*50+50, c2*50+50, c3*50+50, c4*50+50);
    }
  }
  if (b!=0) {    
    line(x2, y2, mouseX, mouseY);
  }


  for (int i=0; i<100; i++) {
    if (arr_lineas[i]==1) {
      win=win+1;
    }
  }
  //println(win, cont_lineas);
  if (win>=cont_lineas-1)
  {
    game=0;
    pantalla=5;
  }
  win=0;
}


//----void mouses----------
int x, y, x1, y1, x2, y2; 
int arrx, arry; 
int b; 
int c; 
int start; 
boolean verdad=true;
int win;
int doble_l[][]=new int[50][50];
int creador;

public void mouseReleased() {
  if (pantalla==1||pantalla==2||pantalla==3&& reglas==1) {

    if (c==0&&start==1) {
      x2=pmouseX;
      y2=pmouseY;
    }
    // println(start, " ", c ); 
    if (u_puntos.getInt((mouseY-25)/50, (mouseX-25)/50)==1) {
      if (start==1) {
        b=contador[(mouseX-25)/50][(mouseY-25)/50]; 
        if (b==contador[(mouseX-25)/50][(mouseY-25)/50]) {
          x=((mouseX+25)/50)*50; 
          y=((mouseY+25)/50)*50;
        } 
        start=2;
      } else if (start==2) {

        b=contador[(mouseX-25)/50][(mouseY-25)/50]; 
        if (b==contador[(mouseX-25)/50][(mouseY-25)/50]) {
          x=((mouseX+25)/50)*50; 
          y=((mouseY+25)/50)*50;
        }
      }
    }
    if (start==0) {
      start=1;
    }
  } else if (pantalla==4&&creador==1) {
    creador=1;
    pantalla=0;
  }
  println(b, " ", c );
  if (b!=0&&c!=0&&conex.getInt(b-1, c-1)==1) {
    x2=x;
    y2=y;
  }

  win=0;

  if (doble_l[b][c]==1||doble_l[c][b]==1&&b!=c) {
    doble_l[b][c]=2;
    doble_l[c][b]=2;
  }

  if ((doble_l[b][c]==0||doble_l[c][b]==0)&&b!=c) {
    doble_l[b][c]=1;
    doble_l[c][b]=1;
  }
  for (int i=0; i<cont_lineas; i++) {
    for (int j=0; j<cont_lineas; j++) {
      if (doble_l[i][j]==2&&b!=c) {
        println(i, j, doble_l[i][j]);
        game=1;
        pantalla=5;
      }
    }
  }

  if (reglas==1) {
    reglas=2;
  }
  if (reglas==0) {
    reglas=1;
  }
  creador=1;
}

public void mousePressed() {


  if (b!=0&&c!=0) {
    //println(conex.getInt(b-1, c-1)==1); 
    if (b==c) {
      verdad=true;
    } else {
      verdad=conex.getInt(b-1, c-1)==1;
    }
  }
  if (b!=0&&c!=0) {
    if (conex.getInt(b-1, c-1)==1) {
      c=b; 
      x1=x; 
      y1=y;
    }
  } else if (b==0||c==0) {
    c=b; 
    x1=x; 
    y1=y;
  }

  if ((doble_l[b][c]==1||doble_l[c][b]==1)&&b!=c) {
    doble_l[b][c]=2;
    doble_l[c][b]=2;
  }
}
