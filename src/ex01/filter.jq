# jq filter: converts the vacancy list from hh.json into CSV
# with the columns "id","created_at","name","has_test","alternate_url"
(["id","created_at","name","has_test","alternate_url"],
 (.vacancies[] | [.id, .created_at, .name, .has_test, .alternate_url]))
| map(if . == null then "" else . end)
| @csv
