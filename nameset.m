load faceClassifier

keySet =   {'s1', 's2', 's3', 's4'};
valueSet = {'Li Bai', 'James Ren', 'Shlomo Goodman', 'Danfeng Xie'};
mapObj = containers.Map(keySet,valueSet);

save faceClassifier  faceClassifier mapObj
