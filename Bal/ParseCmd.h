#include "CaskRow.h"
#include "FormulaRow.h"
#include "ServiceRow.h"
#include "nlohmann/json.hpp"
#include "searchresultrow.h"

class ParseCmd
{
public:
    ParseCmd() {}

    QVector<ServiceRow> parseServicesList(QString &strResult);

    QVector<FormulaRow> parseFormulaList(QString &strResult);

    QVector<CaskRow> parseCaskList(QString &strResult);

    QVector<SearchResultRow *> parseCmdSearch(QString searchResult, bool isCask);

private:
    QString getCaveats(nlohmann::basic_json<> element);
};
