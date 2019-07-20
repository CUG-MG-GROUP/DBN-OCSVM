[digitdata]=xlsread('loading data path',1,'C2:AO6381');

digitdata=mapminmax(digitdata',0,1);
digitdata=digitdata';
numbatches=size(digitdata,1);
numdims  =  size(digitdata,2);
batchsize = 1;
batchdata = zeros(batchsize, numdims, numbatches);
for b=1:numbatches
  batchdata(:,:,b) = digitdata(b,:);
end;