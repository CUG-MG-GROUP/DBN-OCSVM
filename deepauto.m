maxepoch=100; %Number of iterations
first_numhid=128; 
numhid=128;numpen=64; numpen2=32; numopen=16;
makebatches;
[numcases numdims numbatches]=size(batchdata);

fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
rbm;
hidrecbiases=hidbiases;aHid1 = aHid;aVis1 = aVis;err1 = errsum;
save mnistvh vishid hidrecbiases visbiases aHid1 aVis1;
 
fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
batchdata=batchposhidprobs;
numhid=numpen;
restart=1;
rbm;
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;aHid2 = aHid;aVis2 = aVis;err2 = errsum;
save mnisthp hidpen penrecbiases hidgenbiases aHid2 aVis2;

fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
batchdata=batchposhidprobs;
numhid=numpen2;
restart=1;
rbm;
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases; aHid3 = aHid;aVis3 = aVis;err3 = errsum;
save mnisthp2 hidpen2 penrecbiases2 hidgenbiases2 aHid3 aVis3;

fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);
batchdata=batchposhidprobs;
numhid=numopen; 
restart=1;
rbm;
hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases; aHid4 = aHid;aVis4 = aVis;err4 = errsum;
save mnistpo hidtop toprecbiases topgenbiases aHid4 aVis4;


backprop_n;






