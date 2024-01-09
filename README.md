# HyunsukOh_CV
![cv](https://github.com/Uwaang/HyunsukOh_CV/assets/102516673/d55903f0-167e-4f2b-88e1-6a5ddc4a860c)

## Usage
```
git clone https://github.com/Uwaang/HyunsukOh_CV.git
cd HyunsukOh_CV
docker build -t uwaang/cv_image:1.0 --build-arg UID=$UID --build-arg USER_NAME=$USER -f Dockerfile .
docker run -it --name cv_cont01 -v $PWD:/home/$USER/cv -w /home/$USER/cv uwaang/cv_image:1.0
chmod +X script.sh
./script.sh
```
