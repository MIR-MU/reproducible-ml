set -e
set -o pipefail

mkdir -p vectors

for i in cs de en es fi fr hi it pl pt tr zh
do
  if ! [ -e vectors/$i.vec ]
  then
    wget https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.$i.300.vec.gz -O - |
    gzip -d > vectors/$i.vec
  fi
done
