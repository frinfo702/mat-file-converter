# mat-file-converter

# usage 
first of all, install git and docker

🐱git install
- [windows](https://git-scm.com/downloads/win)

🐳docker install
- [windows](https://docs.docker.com/desktop/setup/install/windows-install/)

After installing above
```bash
git clone https://github.com/frinfo702/mat-file-converter.git
```

please move the repository
```bash
cd mat-file-converter
```
set your `.mat`file on `data/input` directory, then excute these command

```bash
docker-compose build
docker-compose up -d
```

please check `data/output` if there are `.csv` datas
