function fieldValues = getNestedField(inStructArray, fieldNameText)
% getNestedField outputs value in the desired nested field of the input
% scalar or array struct
% dynamic field name for multi level nested structs
% 
% fieldValues = getNestedField(inStructArray, fieldNameText)
% inStructArray is the input struct array containing the field fieldNameText
% fieldValues is the value(s) of the fieldNameText of inStructArray
% 
% NOTE: this function converts multi dimensional field elements as row
% vectors (i.e., size 1xn) such that it can be plotted
% 
% example:
% k = [1,2,3;4,5,6;7,8,9]'; % 3x3 array
% st = repmat(struct('a',1,'b',struct('c',k,'d',3)),[2,1]);
% out = getNestedField(st,'b.c')
%
% See also getNestedFieldNames, isNestedField.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

fieldValues = cell2mat(cellfun(...
    @(inStruct) getNestedFieldScalarAsRow(inStruct, fieldNameText),...
    num2cell(inStructArray),...
    'UniformOutput',false));
% for scalar structs, getNestedFieldScalar could also be called here 
% however, i omit to make a scalar check


end

function field = getNestedFieldScalarAsRow(structIn, fieldNameText)
    field = getNestedFieldScalar(structIn, fieldNameText);
    field = field(:)';
end

function field = getNestedFieldScalar(structIn, fieldNameText)

% error('first input must be a scalar structure');

dotInds = strfind(fieldNameText,'.'); % split by struct seperator
if isempty(dotInds)
    field = structIn.(fieldNameText);
    return;
else
    fieldSearchName = fieldNameText(1:dotInds(1)-1); % part before first dot
end
subFieldsName   = fieldNameText(dotInds(1)+1:end); % part after  first dot
field = getNestedField(structIn.(fieldSearchName), subFieldsName);
end