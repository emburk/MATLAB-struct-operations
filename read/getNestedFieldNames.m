function fieldNameList = getNestedFieldNames(structIn)
% getNestedFieldNames lists all nested fields in a struct
% fieldNameList = getNestedFieldNames(structIn)
% Outputs cell array of element names of the input struct
% 
% example:
% out = getNestedFieldNames(struct('a',1,'b',struct('c',2,'d',3)))
%
% See also getSymbolIndices, getStructSize.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

fieldNameList = fieldnames(structIn);
index = 1;
for i = 1:length(fieldNameList)
    if isstruct(structIn.(fieldNameList{index}))
        subList = getNestedFieldNames(structIn.(fieldNameList{index}));
        lenSubList = length(subList);
        for j = 1:lenSubList
            subList(j) = {[fieldNameList{index},'.',subList{j}]};
        end
        % append sublist to field list
        fieldNameList = [fieldNameList(1:index-1); subList; fieldNameList(index+1:end)];
        index = index + lenSubList;
    else % field is non-struct, update index
        index = index + 1;
    end
end
end