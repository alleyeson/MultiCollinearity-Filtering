# MultiCollinearity-Filtering

This code is to detect multi-collinear factor and remove them from you dataset.
Recall in linear algebra variable or column dependence dictates singularity of a matrix (determinant of zero). 

Similarily high correlations amongst varaiables lead to high column dependence, hence bringing the matrix close to singularity.

By picking a correlation and desired determinant threshold, we are able to remove multicolinear effect amongst independent variables.

The correlation threshold will keep variables which lie under the threshold and remove those which do not. 

The determinant threshold leaves a good stopping point for the alogirthm.

The algorithm goes further to retain those with higher correlation to the variable of interest (dependant variable as an input).

Note, these two thresholds possess a see saw effecf in the sense that an increase in precision of one leads to a decrease in the other and vice versa. 

It is up to the user to find the sweet spot based on the data of interest and how much variables one would like to remove.

Example a high level of correlation threshold will result -most of the time- to less a desirable determinant. 
And a high determinant will result in a lot of variable filteration. 
The sweet spot between these numbers depends on the data of interest.
