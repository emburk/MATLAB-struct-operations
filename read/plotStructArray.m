function h = plotStructArray( structArray, fieldName, xValues, varargin )
% plots desired fieldname values of a struct array
% Syntax:
% h = plotStructArray( structArray, fieldName )
% h = plotStructArray( structArray, fieldName, xValues )
% h = plotStructArray( structArray, fieldName, xValues, varargin )
% labels y axis with the struct field name at the lowest level
% 
% Example:
% k = [1,2,3;4,5,6;7,8,9]'; % 3x3 array
% st = repmat(struct('a',1,'b',struct('c',k,'d',3)),[2,1]);
% out = plotStructArray(st,'b.c');
% 
% Note:
% In the Legend, struct fields with multi-dimensional arrays are labeled as
% data1, ... , dataN as matlab organizes dimensions with colon (:) operator
%
% See also getNestedField.
% 
% Author: Mehmet Burak Ekinci
% Mail: elessar208@gmail.com

if nargin < 3
    xValues = 1:length(structArray);
end

if isempty(xValues)
    xValues = 1:length(structArray);
end
%name of desired struct field
dataName = strsplit(fieldName, '.');
dataName = dataName{end};

% i prefer line width = 2, but it can still be overriden with varargin
h = plot(xValues, getNestedField(structArray,fieldName),'LineWidth',2, varargin{:});
legend('show');

title(dataName,'interpreter','none');
set(gcf,'Name',dataName);

xlabel('seconds');
ylabel(dataName,'interpreter','none');
grid on;

end

