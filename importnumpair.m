%% Import data from spreadsheet
% Auto-generated MATLAB plotting script for DBR pairs
clear all
clc
close all
%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 3);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:C11";

% Specify column names and types
opts.VariableNames = ["Numberofpair", "Peakreflectivity", "Usablereflectivitynm"];
opts.VariableTypes = ["double", "double", "double"];

% Import the data
tbl = readtable("data\numpair.xlsx", opts, "UseExcel", false);

%% Convert to output type
Numberofpair = tbl.Numberofpair;
Peakreflectivity = tbl.Peakreflectivity;
Usablereflectivitynm = tbl.Usablereflectivitynm;

%% Clear temporary variables
clear opts tbl
%% Plotting data
x = linspace(0,50)
y = linspace(0,1)
figure
yyaxis left;
plot (Numberofpair,Peakreflectivity,'b.-','linewidth',2);
ylabel('Reflective index');

hold on;
yyaxis right;
grid on;

plot (Numberofpair,Usablereflectivitynm,'linewidth',2);
hold on;

title ('Reflectivity and usable reflectivity in terms of number of pairs');
xlabel ('Number of pairs');
ylabel ('Width of usable reflectivity at 0.97');
