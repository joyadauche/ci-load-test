set -e
cd ./tests/

echo 'LOAD_TEST_OUTPUT<<EOF' >> $GITHUB_OUTPUT
echo "$(k6 run -q --summary-trend-stats="avg,p(90),p(95)" load-test.js)" >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT