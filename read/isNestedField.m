function out = isNestedField(structIn, fieldNameText)
% isNestedField checks if fieldNameText exists structIn
% out = isNestedField(structIn, fieldNameText)
% 
% example:
% for a struct a.b.c = 1 -> 
% isNestedField(a,'b.c') returns true 
% isNestedField(a,'b')   returns true 
% isNestedField(a,'c')   returns false 
% 
% See also getNestedField.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com
if isstruct(structIn)
    dotInds = strfind(fieldNameText,'.'); % split by struct seperator
    if isempty(dotInds) % last nest level
        out = isfield(structIn,fieldNameText);
        return;
    else % there are more nest levels
        fieldSearchName = fieldNameText(1:dotInds(1)-1); % part before first dot
        subFieldsName   = fieldNameText(dotInds(1)+1:end); % part after  first dot
        if isfield(structIn, fieldSearchName)
            if isstruct(structIn.(fieldSearchName))
                out = isNestedField(structIn.(fieldSearchName),subFieldsName);
                return;
            end
        end
    end
end
% if code has not returned yet, output is false
out = false;
return;
end