set -e
set -o pipefail

mkdir -p analogies

[ -e analogies/cs.txt ] || wget https://raw.githubusercontent.com/Svobikl/cz_corpus/master/corpus/czech_emb_corpus_no_phrase.txt -O - > analogies/cs.txt
[ -e analogies/de.txt ] || (
  TEMPDIR=`mktemp -d`
  pushd $TEMPDIR
  wget https://www.ims.uni-stuttgart.de/documents/ressourcen/lexika/analogies_ims/analogies.zip
  unzip analogies.zip
  cat analogies/de_trans_Google_analogies.txt
  popd
  rm -rf $TEMPDIR
)  > analogies/de.txt
[ -e analogies/en.txt ] || wget https://github.com/tmikolov/word2vec/raw/master/questions-words.txt -O - > analogies/en.txt
[ -e analogies/es.txt ] || wget https://cs.famaf.unc.edu.ar/~ccardellino/SBWCE/questions-words_sp.txt -O - > analogies/es.txt
[ -e analogies/fi.txt ] || (
  for i in antonymic_adjectives capital-country cardinal-ordinal_numbers country-currency female-male hockeyTeam-city orthogonal_directions
  do
    echo : $i
    wget https://raw.githubusercontent.com/venekoski/FinSemEvl/master/FinSemEvl/analogy/ANA_$i.txt -O -
  done
)  > analogies/fi.txt
[ -e analogies/fr.txt ] || (
  wget https://dl.fbaipublicfiles.com/fasttext/word-analogies/questions-words-fr.txt -O - |
  sed 's/^ *:/:/'
)  > analogies/fr.txt
[ -e analogies/hi.txt ] || (
  wget https://dl.fbaipublicfiles.com/fasttext/word-analogies/questions-words-hi.txt -O - |
  sed 's/^ *:/:/'
)  > analogies/hi.txt
[ -e analogies/it.txt ] || wget https://web.archive.org/web/20170511144953if_/http://hlt.isti.cnr.it:80/wordembeddings/questions-words-ITA.txt -O - > analogies/it.txt
[ -e analogies/pl.txt ] || (
  wget https://dl.fbaipublicfiles.com/fasttext/word-analogies/questions-words-pl.txt -O - |
  sed 's/^ *:/:/'
)  > analogies/pl.txt
[ -e analogies/pt.txt ] || wget https://raw.githubusercontent.com/nathanshartmann/portuguese_word_embeddings/master/analogies/testset/LX-4WAnalogies.txt -O - > analogies/pt.txt
[ -e analogies/tr.txt ] || (
  wget http://myweb.sabanciuniv.edu/umutsen/files/2017/11/questions_analogy.txt.gz -O - | gzip -d
  TEMPDIR=`mktemp -d`
  pushd $TEMPDIR
  wget https://github.com/onurgu/linguistic-features-in-turkish-word-representations/releases/download/v1.0/analogy-test-set.zip
  unzip analogy-test-set.zip
  for i in both_inflection_derivation.quads derivation_quads noun_inflection_quads verb_inflection_quads
  do
    echo : $i
    cat $i.txt
  done
  popd
  rm -rf $TEMPDIR
)  > analogies/tr.txt
[ -e analogies/zh.txt ] || wget https://raw.githubusercontent.com/Leonard-Xu/CWE/master/data/analogy.txt -O - > analogies/zh.txt
