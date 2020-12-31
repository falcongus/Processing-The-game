class MapMaker{
  String[][] lab,mas;
  int w,h;
  MapMaker(int h,int w){
    this.h=h;
    this.w=w;
    this.lab=makeMapStai(h,w);
    int colvo=0;
    if(1==1){
      for(int y=0;y<h;y++){
        for(int x=0;x<w;x++){
          if(lab[y][x]=="wd"){colvo+=2;}
          else if(lab[y][x]!=""){colvo++;}
        }
        if(y>0 && y<h-1){
          for(int x=2;x<w/10-1;x++){
            int o=int(random((x-1)*(w/10),x*(w/10)));
            lab[y][o]="";
            println(o);
          }
        }
      }
      println(colvo);
    }
  }
  
  String[][] makeMap(int h,int w){
    int nk,nk0,r;
    lab=new String[h][w];
    
    for (int y=0;y<h;y++){
      for (int x1=0;x1<w;x1++){lab[y][x1]="wd";}
      int x=0;
      while(x<w){
        nk0=0;
        r=int(random(2));
        while(r==0 && x<w-1){
          if(lab[y][x]=="wd"){lab[y][x]="w";}
          nk0++;
          x++;
          r=int(random(2));
        }
        r=int(random(x-nk0+1));
        if(lab[y][x-r]=="wd"){
          lab[y][x-r]="d";
        }
        else if(lab[y][x-r]=="w"){lab[y][x-r]="";}
        x++;
      }
    }
    return lab;
  }
  
  
  
  String[][] makeMapStai(int h,int w){
    int nk,nk0,r,r1;
    lab=new String[h][w];
    for (int y=0;y<h;y++){
      for (int x1=0;x1<w;x1++){lab[y][x1]="wd";}
      int x=1;
      
      while(x<w-1){
        nk0=x;
        int hh=x;
        r=int(random(2));
        while(hh<w-1 && r==0){
          hh++;
          r=int(random(2));
        }
        //r=int(random(w-x-1))+1;
        r=hh-nk0;
        
        //r=int(random(r))+1;
        while(r>0 ){
          if(lab[y][x]=="wd" ){lab[y][x]="w";}
          x++;
          r--;
        }
        r1=-int(random(x-nk0))-1;
        if(lab[y][x+r1]=="wd"){
          lab[y][x+r1]="d";
        }
        else if(lab[y][x+r1]=="w"){lab[y][x+r1]="";}
        x++;
      }
      
      if((lab[y][w-1]=="d" || lab[y][w-1]=="wd") && (lab[y][w-2]=="wd")){
        lab[y][w-2]="w";
      }
    }
    for (int x1=0;x1<w;x1++){lab[0][x1]="w";}
    for (int x1=0;x1<h;x1++){
      if (lab[x1][0]==""){
        lab[x1][0]="d";
      }else if(lab[x1][0]=="w"){
        lab[x1][0]="wd";
      }
    }
    for(int y=0;y<h;y++){
      lab[y][w-1]="d";
    }
    for(int x=0;x<w-1;x++){
      lab[h-1][x]="w";
    }
    lab[h-1][w-1]="";
    return lab;
  }
}