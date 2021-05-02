%% Import data from spreadsheet
% Auto-generated MATLAB plotting script for Q-factor
clear all; close all; clc
%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 47);

% Specify sheet and range
opts.Sheet = "Master";
opts.DataRange = "A1:AU18";

% Specify column names and types
opts.VariableNames = ["lengthofmetalAu", "Var2", "Var3", "Var4", "Var5", "Var6", "qfactor", "Var8", "lengthofspacer", "Var10", "Var11", "Var12", "Var13", "Var14", "qfactors", "Var16", "lengthofmetalAg", "Var18", "Var19", "Var20", "Var21", "Var22", "qfactorag", "Var24", "lengthofmetalAuJM", "Var26", "Var27", "Var28", "Var29", "Var30", "qfactorJM", "Var32", "lengthofmetalAgJM", "Var34", "Var35", "Var36", "Var37", "Var38", "qfactorJMAG", "Var40", "lengthofspacerAg", "Var42", "Var43", "Var44", "Var45", "Var46", "qfactorAGS"];
opts.SelectedVariableNames = ["lengthofmetalAu", "qfactor", "lengthofspacer", "qfactors", "lengthofmetalAg", "qfactorag", "lengthofmetalAuJM", "qfactorJM", "lengthofmetalAgJM", "qfactorJMAG", "lengthofspacerAg", "qfactorAGS"];
opts.VariableTypes = ["double", "string", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double"];
opts = setvaropts(opts, [2, 3, 4, 5, 6, 8, 10, 11, 12, 13, 14, 16, 18, 19, 20, 21, 22, 24, 26, 27, 28, 29, 30, 32, 34, 35, 36, 37, 38, 40, 42, 43, 44, 45, 46], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [2, 3, 4, 5, 6, 8, 10, 11, 12, 13, 14, 16, 18, 19, 20, 21, 22, 24, 26, 27, 28, 29, 30, 32, 34, 35, 36, 37, 38, 40, 42, 43, 44, 45, 46], "EmptyFieldRule", "auto");

% Import the data
tbl = readtable("data\metalthickness.xlsx", opts, "UseExcel", false);

%% Convert to output type
lengthofmetalAu = tbl.lengthofmetalAu;
qfactor = tbl.qfactor;
lengthofspacer = tbl.lengthofspacer;
qfactors = tbl.qfactors;
lengthofmetalAg = tbl.lengthofmetalAg;
qfactorag = tbl.qfactorag;
lengthofmetalAuJM = tbl.lengthofmetalAuJM;
qfactorJM = tbl.qfactorJM;
lengthofmetalAgJM = tbl.lengthofmetalAgJM;
qfactorJMAG = tbl.qfactorJMAG;
lengthofspacerAg = tbl.lengthofspacerAg;
qfactorAGS = tbl.qfactorAGS;

%% Clear temporary variables
clear opts tbl
%%  Metal and DBR graph
figure
plot(lengthofmetalAuJM,qfactorJM,'DisplayName','qfactorJM','linewidth',2);
hold on
plot(lengthofmetalAgJM,qfactorJMAG,'DisplayName','qfactorJM','linewidth',2);
xlabel ('metal thickness(nm)');
ylabel ('Q-factor');
title ('Q factor of DBR + Metal layer at different thickness');
legend ('Au','Ag','Location','southeast');
ylim([40 230]);
hold off;
grid on;
%%  Fixed spacer and varying metal thickness
figure
plot(lengthofmetalAu,qfactor,'DisplayName','qfactor','linewidth',2);
hold on;
plot(lengthofmetalAg,qfactorag,'DisplayName','qfactorag','linewidth',2);
hold off;
grid on;
xlim ([10 60]);
legend ('Au','Ag','Location','southeast');
xlabel ('metal thickness(nm)');
ylabel ('Q-factor');
title ('Ag vs Au (with spacer) in terms of Q-factor at different thickness');
%%  Fixed metal thickness and varying spacer thickness
figure
plot(lengthofspacer,qfactors,'DisplayName','qfactors','linewidth',2)
hold on
plot(lengthofspacerAg,qfactorAGS,'DisplayName','qfactors','linewidth',2)
xlim([20 90]);
xticks(0:10:100);
legend('Au metal','Ag metal')
grid on
xlabel ('Spacer thickness(nm)');
ylabel ('Q-factor');
title ('Q-factor of spacer at different thickness');
%%  Master list
figure
plot(lengthofmetalAuJM,qfactorJM,'DisplayName','qfactorJM','linewidth',2);
hold on;
plot(lengthofmetalAgJM,qfactorJMAG,'DisplayName','qfactorJM','linewidth',2);
plot(lengthofmetalAu,qfactor,'DisplayName','qfactor','linewidth',2);
plot(lengthofmetalAg,qfactorag,'DisplayName','qfactorag','linewidth',2);
grid on;
xlim([10 65]);
ylim([30 230]);
legend('Au','Ag','Au + spacer','Ag + spacer','Location','southeast')
xlabel ('metal thickness(nm)');
ylabel ('Q-factor');