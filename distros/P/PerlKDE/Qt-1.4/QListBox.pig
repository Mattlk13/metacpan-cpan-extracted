#include <qlistbox.h>

suicidal virtual class QListBox : virtual QTableView {
    QListBox(QWidget * = 0, const char * = 0, WFlags = 0);
    virtual ~QListBox();
    bool autoBottomScrollBar() const;
    bool autoScroll() const;
    bool autoScrollBar() const;
    bool autoUpdate() const;
    bool bottomScrollBar() const;
    void centerCurrentItem();
    void changeItem(const char *, int);
    void changeItem(const QPixmap &, int);
    void changeItem(const QListBoxItem *, int);
    void clear();
    void clearSelection() slot;
    uint count() const;
    int currentItem() const;
    bool dragSelect() const;
    void insertItem(const char *, int = -1);
    void insertItem(const QPixmap &, int = -1);
    void insertItem(const QListBoxItem *, int = -1);
    void insertStrList(const QStrList *, int = -1);
    void inSort(const char *);
    void inSort(const QListBoxItem *);
    bool isMultiSelection() const;
    bool isSelected(int) const;
    int itemHeight() const;
    int itemHeight(int) const;
    int numItemsVisible() const;
    long maxItemWidth() const;
    const QPixmap *pixmap(int) const;
    void removeItem(int);
    bool scrollBar() const;
    void setAutoBottomScrollBar(bool);
    void setAutoScroll(bool);
    void setAutoScrollBar(bool);
    void setAutoUpdate(bool);
    void setBottomScrollBar(bool);
    void setCurrentItem(int);
    void setDragSelect(bool);
    void setFixedVisibleLines(int);
    virtual void setFont(const QFont &);
    void setMultiSelection(bool);
    void setScrollBar(bool);
    void setSelected(int, bool);
    void setSmoothScrolling(bool);
    void setTopItem(int);
    virtual QSize sizeHint() const;
    bool smoothScrolling() const;
    const char *text(int) const;
    int topItem() const;
protected:
    virtual int cellHeight(int = 0);
    void clearList();
    int findItem(int) const;
    virtual void focusInEvent(QFocusEvent *);
    virtual void focusOutEvent(QFocusEvent *);
    void highlighted(int) signal;
    void highlighted(const char *) signal;
    QListBoxItem *item(int) const;
    bool itemVisible(int);
    bool itemYPos(int, int *) const;
    virtual void keyPressEvent(QKeyEvent *);
    virtual void mouseDoubleClickEvent(QMouseEvent *);
    virtual void mouseMoveEvent(QMouseEvent *);
    virtual void mousePressEvent(QMouseEvent *);
    virtual void mouseReleaseEvent(QMouseEvent *);
    virtual void paintCell(QPainter *, int, int);
    virtual void resizeEvent(QResizeEvent *);
    void selected(int) signal;
    void selected(const char *) signal;
    void selectionChanged() signal;
    virtual void timerEvent(QTimerEvent *);
    void toggleCurrentItem();
    void updateCellWidth();
    void updateItem(int, bool = TRUE);
} Qt::ListBox;
