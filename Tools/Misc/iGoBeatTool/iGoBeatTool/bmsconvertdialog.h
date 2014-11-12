#ifndef BMSCONVERTDIALOG_H
#define BMSCONVERTDIALOG_H

#include <QDialog>
#include <QTextDocument>
#include <QListWidgetItem>

namespace Ui {
class BmsConvertDialog;
}

class BmsConvertDialog : public QDialog
{
    Q_OBJECT
    
public:
    explicit BmsConvertDialog(QWidget *parent = 0);
    ~BmsConvertDialog();
    
private slots:
    void on_selectBmsButton_clicked();
    void on_convertButton_clicked();
    void onSelectAll(int state);

private:
    void UpdateInformationForUser();
    void UpdateListViewContent();
    void ConvertBMSFile(QString bms_file_dir);
    void CompressIGoBeatDir(const QString& igobeat_files_dir);
    void CopySongMeadiaFile(const QString &igobeat_files_dir);

    Ui::BmsConvertDialog *ui;
    QString             bms_convert_root_workpath_;
    QStringList         bms_dir_path_list_;
    QTextDocument       information_for_user_;
};

#endif // BMSCONVERTDIALOG_H
