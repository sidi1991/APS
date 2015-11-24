int main(){
  double A[5][6]={{2,2,3,4,5,7},{7,9,9,10,11,14},{13,14,16,16,17,21},{19,20,21,23,23,28},{25,26,27,28,30,35}};
  double b;
  int N = 5,i,j,k;
	for(i = 0; i < N; i++) {
       		for(j = 0; j < N; j++) {
			if(j > i){
	           		double ratio = A[j][i]/A[i][i];
        	   		for(k = 0; k <= N; k++) {
                			b = (ratio*A[i][k]);
                			A[j][k] = A[j][k] - (A[i][k] * ratio);
           			}
			}
       		}
  	} 
  return 0;
}
