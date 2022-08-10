function outList = getSymbolIndices(inStruct)
% getSymbolIndices returns information about nested struct
% function outList = getSymbolIndices(inStruct) outputs cell array of input
% structs each element names, element class, byte size and starting index
% of the element assuming there are no paddings inserted by compiler (see
% note 1) or each symbol is aligned by 1 byte.
% 
% NOTE1: compilers may insert empty bytes inside structs for speed
% optimization, for example a struct having uint16 and double succesively
% has 6 bytes of empty memory. See following reference for further reading:
% https://en.wikipedia.org/wiki/Data_structure_alignment
% 
% example:
% outList = getSymbolIndices(struct('a',1,'b',struct('c',2,'d',3)))
% 
% See also getSymbolIndices, getStructSize.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com


% check if u are on correct git version!!
fieldNameList = getNestedFieldNames(inStruct);


lenFields = length(fieldNameList);

outList = cell(lenFields+1,4);
currentIndex = 0;

outList{1,1} = 'Symbol Name';
outList{1,2} = 'Symbol Class';
outList{1,3} = 'Symbol Byte Size';
outList{1,4} = 'Symbol Index';


for i = 1:lenFields
    outList(i+1,1) = fieldNameList(i);
    var = getNestedField(inStruct, fieldNameList{i});
    className = class(var);
    outList{i+1,2} = className;
    varSize = typeSize(var)* numel(var);
    outList{i+1,3} = num2str(varSize);
    outList{i+1,4} = num2str(currentIndex);
    currentIndex = currentIndex + varSize;
end

end



function valSize = typeSize(val)

switch class(val)
    case 'logical'
        valSize = 1;
    case 'uint8'
        valSize = 1;
    case 'int16'
        valSize = 2;
    case 'uint16'
        valSize = 2;
    case 'int32'
        valSize = 4;
    case 'uint32'
        valSize = 4;
    case 'single'
        valSize = 4;
    case 'int64'
        valSize = 8;
    case 'uint64'
        valSize = 8;
    case 'double'
        valSize = 8;
    otherwise
        error(strcat('Unknown data type : ', class(val)));
end
end