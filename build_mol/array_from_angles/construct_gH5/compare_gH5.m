
%loadxy('1zbb_tetra.pdb.dat');
t1zbb.raw = loadxy('1zbb_tetra_combined.pdb.dat');
c11.raw = loadxy('c11_r.pdb.dat');
gh5_initial.raw = loadxy('manual_gH5x4.pdb.dat');
gh5_protein.raw = loadxy('gH5x4_allProteins.pdb.dat');
gh5_complete.raw = loadxy('complete_gH5x4.pdb.dat');

t1zbb.n = [t1zbb.raw(:,1), t1zbb.n(:,2:end)/t1zbb.n(1,2)];
c11.n = [c11.raw(:,1), c11.n(:,2:end)/c11.n(1,2)];
gh5_initial.n = [gh5_initial.raw(:,1), gh5_initial.n(:,2:end)/gh5_initial.n(1,2)];
gh5_protein.n = [gh5_protein.raw(:,1), gh5_protein.n(:,2:end)/gh5_protein.n(1,2)];
gh5_complete.n = [gh5_complete.raw(:,1), gh5_complete.n(:,2:end)/gh5_complete.n(1,2)];

%data = loadxy('/home/schowell/Dropbox/gw_phd/paper_tetranucleosome/1406data/chess/iqdata/c000_4x167_h5_k010.i0q');
data.raw = loadxy('/home/schowell/Dropbox/gw_phd/paper_tetranucleosome/1406data/chess/iqdata/c000_4x167_h5_mg1.i0q');
data.iq = [c11.raw(:,1), interp1(data.raw(:,1), data.raw(:,2), c11.raw(:,1)), interp1(data.raw(:,1), data.raw(:,3), c11.raw(:,1))];
 
match_type = 'all';
t1zbb.iq = scale_offset(t1zbb.n, data.iq, match_type);
c11.iq = scale_offset(c11.n, data.iq, match_type);
gh5_initial.iq = scale_offset(gh5_initial.n, data.iq, match_type);
gh5_protein.iq = scale_offset(gh5_protein.n, data.iq, match_type);
gh5_complete.iq = scale_offset(gh5_complete.n, data.iq, match_type);

figure;
hold all
xyerror(data.iq(2:end,:), 's');
xyplot(t1zbb.n(2:end,:));
xyplot(c11.n(2:end,:));
xyplot(gh5_initial.n(2:end,:));
% xyplot(gh5_protein.n(2:end,:));
xyplot(gh5_complete.n(2:end,:));

% legend('1. Exp 4x167 gH5', '2. PDB:1ZBB', '3. All DNA & Proteins added to 2', '4. 4 gH5 NCPs', '5. All Proteins added to 4', '6. All DNA added to 6', 'location', 'southwest');
legend('1. Exp 4x167 gH5', '2. PDB:1ZBB', '3. All DNA & Proteins added to 2', '4. 4 gH5 NCPs', '5. All DNA & Proteins added to 4', 'location', 'southwest');
legend boxoff

logxy;
axis tight
zoomout(0.1);
iqlabel
saveps(gcf, 'compare_gH5.eps')
savepng(gcf, 'compare_gH5.png')
