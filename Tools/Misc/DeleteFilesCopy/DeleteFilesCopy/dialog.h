#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QtGui>

namespace Ui {
class Dialog;
}

class Dialog : public QDialog
{
    Q_OBJECT
    
public:
    explicit Dialog(QWidget *parent = 0);
    ~Dialog();

private slots:
    void SelectRootPath();
    void SelectSubPath();
    void DeleteCopy();

private:
    void UpdateInfomationForUser();

    Ui::Dialog *ui;
    QString         root_directory_path_;
    QString         sub_directory_path_;
    QTextDocument   information_for_user_;
};

#endif // DIALOG_H
