function field = getNestedField(structIn, fieldNameText)
% getNestedField outputs value in the desired nested field of the input
% struct
% field = getNestedField(structIn, fieldNameText)
% structIn is the input struct containing the field fieldNameText
% field is the value of the fieldNameText of structIn
% 
% example:
% st = struct('a',1,'b',struct('c',2,'d',3));
% out = getNestedField(st,'b.c')
%
% See also getNestedFieldNames, isNestedField.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

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