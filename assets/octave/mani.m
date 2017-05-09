clear

# manipulator constants
a = 144.5
b = 220

# generate angles in radians
res = 100
alpha = linspace(30, 135, res)
beta = linspace(120, 225, res)

x = zeros(res,res)
y = zeros(res,res)

[i,j] = meshgrid(1:numel(alpha),1:numel(beta))
x = a * cosd(alpha(i)) + b * cosd(180 - beta(j))
y = a * sind(alpha(i)) - b * sind(180 - beta(j))

# generate linear approximation
res = 25
x_lin = linspace(120, 300, res)
y_lin = linspace(-150, 200, res)
alpha_angles = zeros(res,res)
beta_angles = zeros(res,res)

k = linspace(1, numel(alpha), numel(alpha))
l = linspace(1, numel(beta), numel(beta))

cost = zeros(numel(alpha),numel(beta))

for i = 1:numel(x_lin)
  for j = 1:numel(y_lin)
    
    cost = (x(k,l) - x_lin(i)).^2 + (y(k,l) - y_lin(j)).^2
    
    minimum = min(cost(:))
    [row, col] = find(cost==minimum)
    
    alpha_angles(i,j) = alpha(col)
    beta_angles(i,j) = beta(row)
    
  endfor
endfor

save("inverse kinematics.txt", "alpha_angles", "beta_angles", "x_lin", "y_lin")

dlmwrite("alpha.csv", alpha_angles, "delimiter", ",", "precision", 3, "newline", "],\n[", "roffset",1)
dlmwrite("beta.csv", beta_angles, "delimiter", ",", "precision", 3, "newline", "],\n[", "roffset",1)
dlmwrite("x_lin.csv", x_lin, "delimiter", ",", "precision", 3, "newline", "],\n[", "roffset",1)
dlmwrite("y_lin.csv", y_lin, "delimiter", ",", "precision", 3, "newline", "],\n[", "roffset",1)