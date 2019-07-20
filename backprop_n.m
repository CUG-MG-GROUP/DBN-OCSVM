
makebatches;
[numcases numdims numbatches]=size(batchdata);
N=numcases; 

%%%% PREINITIALIZE WEIGHTS OF THE AUTOENCODER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w1=[vishid; hidrecbiases];
w2=[hidpen; penrecbiases];
w3=[hidpen2; penrecbiases2];
w4=[hidtop; toprecbiases];


%%%%%%%%%% END OF PREINITIALIZATIO OF WEIGHTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l1=size(w1,1)-1;
l2=size(w2,1)-1;
l3=size(w3,1)-1;
l4=size(w4,1)-1;

%%%%%%%%%%%%%%%%%%%% COMPUTE TRAINING RECONSTRUCTION ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = zeros(numbatches, numopen);

  for batch = 1:numbatches
  datai = [batchdata(:,:,batch)];
  datai = [datai ones(N,1)];
  
  w1probs = 1./(1 + exp(-datai*w1)); w1probs = [w1probs  ones(N,1)];
  w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N,1)];
  w3probs = 1./(1 + exp(-w2probs*w3)); w3probs = [w3probs  ones(N,1)];
  w4probs = w3probs*w4;
  data(batch,:) = w4probs;
  end
  
  labels = ones(numbatches,1);
  % Construct one-class SVM with RDF kernel (Gaussian)
  model = svmtrain(labels, data, '-s 2 -t 3');
  % Use the same data for label prediction
  [predicted_labels,temp,predicted_prob] = svmpredict(labels, data, model);
  
  
  
  
  
  