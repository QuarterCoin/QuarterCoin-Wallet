#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

QTCD=${QTCD:-$SRCDIR/quartercoind}
QTCCLI=${QTCCLI:-$SRCDIR/quartercoin-cli}
QTCTX=${QTCTX:-$SRCDIR/quartercoin-tx}
QTCQT=${QTCQT:-$SRCDIR/qt/quartercoin-qt}

[ ! -x $QTCD ] && echo "$QTCD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
QTCVER=($($QTCCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for quartercoind if --version-string is not set,
# but has different outcomes for quartercoin-qt and quartercoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$QTCD --version | sed -n '1!p' >> footer.h2m

for cmd in $QTCD $QTCCLI $QTCTX $QTCQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${QTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${QTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
