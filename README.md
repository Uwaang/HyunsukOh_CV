# HyunsukOh_CV
![cv](cv.png)

# Notes
* Should you require my phone number, please contact me through the email in CV.

## Usage
```
git clone https://github.com/Uwaang/HyunsukOh_CV.git
cd HyunsukOh_CV
docker build -t uwaang/cv_image:1.0 --build-arg UID=$UID --build-arg USER_NAME=$USER -f Dockerfile .
docker run -it --name cv_cont01 -v $PWD:/home/$USER/cv -w /home/$USER/cv uwaang/cv_image:1.0
chmod +X script.sh
./script.sh
```
