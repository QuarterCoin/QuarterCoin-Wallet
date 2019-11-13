// Copyright (c)  The Bitcoin Core developers
// Copyright (c) 2017 The Raven Core developers
// Copyright (c) 2018 The Quartercoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef QTC_QT_QTCADDRESSVALIDATOR_H
#define QTC_QT_QTCADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class QuartercoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit QuartercoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Quartercoin address widget validator, checks for a valid quartercoin address.
 */
class QuartercoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit QuartercoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // QTC_QT_QTCADDRESSVALIDATOR_H
