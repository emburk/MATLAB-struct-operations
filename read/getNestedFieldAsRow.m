function field = getNestedFieldAsRow(structIn, fieldNameText)
% getNestedFieldAsRow outputs value in the desired nested field of the input
% scalar struct as row
% 
% field = getNestedField(structIn, fieldNameText)
% structIn is the input struct containing the field fieldNameText
% field is the value of the fieldNameText of structIn
% 
% example:
% st = struct('a',1,'b',struct('c',2,'d',3));
% out = getNestedField(st,'b.c')
%
% See also getNestedField, getNestedFieldNames, isNestedField.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

field = getNestedField(structIn, fieldNameText);
field = field(:)';

end