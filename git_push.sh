#a shell script to create a github repository
#!/bin/bash
username=""
token=""
branch="main"
comment="a new repository"
explain_command(){
    while getopts ":c:b:" opt;do
        case $opt in
            c ) comment="$OPTARG" 
	        echo "|-> the comment has been set"
	        ;;
            b ) branch="$OPTARG"
            ;;
            \?) echo "|-> Usage: $0 [-c comment]"
            ;;
        esac
    done
}
username=$(sed -n 1p TOKEN | tr -d "\n")
echo $username
token=$(sed -n 2p TOKEN | tr -d "\n")
repo_name=$(basename "$PWD")
explain_command
if [ -d ".git" ];then
    echo "|-> Push"
    git add .
    git commit -m "$comment"
    git branch -M main
    git remote add origin "https://github.com/$username/$repo_name.git"
    git push origin main
else
    echo "|-> This catagory is not a repository"
    echo "|-> Init it"
    git init
    git add .
    git commit -m "$comment"
    echo "|-> Create it on Github"
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
    echo "|-> Push"
    git branch -M main
    git remote add origin "https://github.com/$username/$repo_name.git"
    git push origin main
fi