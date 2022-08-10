function [structSize, structSizeWPadding] = getStructSize( structIn )
% getStructSize Calculates size of a matlab struct as if it is
% codegenerated to a C file equal to sizeof(typeofStructIn) in C
% 
% [structSize, structSizeWPadding] = getStructSize( structIn )
% 
% Inputs:
%  structIn: a matlab struct
% Outputs: 
%  structSize: size of 1 byte aligned struct (ignores paddings inserted by compiler)
%  structSizeWPadding: size including paddings inserted by CPU, assuming
%  following padding rules:
% 
%   1. Each individual member of the input struct and its sub-structs 
%      should start at an address divisible by its size:
%     a. int8, uint8, boolean, char : 1 byte : can start anywhere
%     b. int16, uint16 : 2 bytes : start at address divisible by 2
%     c. int32, uint32, single : 4 bytes : start at address divisible by 4
%     d. int64, uint64, double : 8 bytes : start at address divisible by 8
%
%   2. The size of the input struct and its sub-structs
%      should be divisible by the size of its largest member. 
%      Ex: if struct has a double member, struct size should be
%      divisible by 8 bytes.
% 
% 
% example: [o1, o2] = getStructSize( struct('a',uint8(1), 'b', 1) ) -> 9 16
% 
% See also getSymbolIndices.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

% current indexes are 0 at start
[structSize, structSizeWPadding] = getStructSizeRecursive( structIn,0,0 );
end

function [structSize, structSizeWPadding] = ...
    getStructSizeRecursive( structIn,structSize,structSizeWPadding )
% input structSize and structSizeWPadding are memory index without and
% with counting paddings (inserted by CPU) respectively
% function is called recursively untill all struct sub-fields are processed

if isstruct(structIn) % structIn is a struct
    fieldNameList = fieldnames(structIn);
    % save initial memory address index
    initStructSize = structSize;
    initStructSizeWPadding = structSizeWPadding;
    
    for i = 1:length(fieldNameList)
        [structSize, structSizeWPadding]...
            = getStructSizeRecursive( structIn(1).(fieldNameList{i}),...
                                      structSize,...
                                      structSizeWPadding);
    end
    % add struct size * struct number of elements to initial memory address:
    structSize         = initStructSize ...
                       + numel(structIn)...
                       * (structSize - initStructSize);
    structSizeWPadding = initStructSizeWPadding ...
                       + numel(structIn)...
                       * (structSizeWPadding - initStructSizeWPadding);
    
    
else % structIn is not a struct
    size2add = typeSize(structIn) * numel(structIn);
    padding = checkDataAlignment(typeSize(structIn), structSizeWPadding);
    structSize = structSize + size2add;
    structSizeWPadding = structSizeWPadding + size2add + padding;
    return;
end



end


function necessaryPadding = checkDataAlignment(dataTypeSize, currentMemoryIndex)

% Check the data alignment
alignment = mod(currentMemoryIndex, dataTypeSize);

% Calculate the padding if the structure is not aligned
if(alignment > 0)
    necessaryPadding = dataTypeSize - alignment;
else
    necessaryPadding = 0;
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