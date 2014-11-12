#ifndef MOVEFILESDIALOG_H
#define MOVEFILESDIALOG_H

#include <QDialog>
#include <QtGui>

namespace Ui {
class MoveFilesDialog;
}

class MoveFilesDialog : public QDialog
{
    Q_OBJECT
    
public:
    explicit MoveFilesDialog(QWidget *parent = 0);
    ~MoveFilesDialog();

private slots:
    void SelectNamesFile();
    void SelectPath();
    void MoveFiles();

private:
    void UpdateInfomationForUser();

    Ui::MoveFilesDialog *ui;
    QString         files_path_;
    QString         names_file_path_;
    QTextDocument   information_for_user_;
};

#endif // MOVEFILESDIALOG_H
