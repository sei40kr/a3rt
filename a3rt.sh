# Check that API key is specified
if [ -z "${API_KEY}" ]
then
  echo -n "\033[31m"
  echo -n "API key not specified. Run this with your API key like below"
  echo "\033[m"
  echo -n "\033[32m"
  echo "    API_KEY=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ./a3rt.sh"
  echo "\033[m"
  exit 1
fi

a3rt_reply() {
  local message=$1
  curl -sX POST 'https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk' \
    -F "apikey=${API_KEY}" \
    -F "query=${message}" | jq -r .results[0].reply
}

while :
do
  echo -n "You: "
  read message
  [ "$message" = "bye" ] && echo "Bye.\n" && break

  echo -n "A3RT: "
  echo -n "\033[36m"
  a3rt_reply "$message"
  echo -n "\033[m"
done

