
sets i origin zones      /1*3/
     j destination zones /1*3/;

parameters
     o(i) generation rate of zone i
       /1  28
        2  51
        3  26/

      d(j) attraction rate of zone j
       /1  28
        2  50
        3  27/;

table c(i,j) unit cost
           1    2   3
      1    7    17  22
      2    17   15  23
      3    22   23  7 ;

scalar
       T_tot total traffic flow /4/ ;
scalar
       C_tot total cost in this research region /1475/;

positive variables
       T(i,j) flow from zone i to zone j ;
T.lo(i,j)=0.01;
variables
       H entropy value ;

equations
       entropy       define objective funcion
       generation(i) observed totoal generation rate
       attraction(j) observed totoal attraction rate
       total_cost    observed totoal cost;
entropy..  H=e=-sum((i,j),T(i,j)*log(T(i,j)));
generation(i).. sum(j,T(i,j))=e=o(i);
attraction(j).. sum(i,T(i,j))=e=d(j);
total_cost.. sum((i,j),T(i,j)*c(i,j))=e=C_tot;
model ODME /all/;
solve ODME using nlp maximizing H;
display H.l,T.l;



