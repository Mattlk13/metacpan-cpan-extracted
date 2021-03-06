/* 
 * tkText.c --
 *
 *	This module provides a big chunk of the implementation of
 *	multi-line editable text widgets for Tk.  Among other things,
 *	it provides the Tcl command interfaces to text widgets and
 *	the display code.  The B-tree representation of text is
 *	implemented elsewhere.
 *
 * Copyright (c) 1992-1994 The Regents of the University of California.
 * Copyright (c) 1994-1996 Sun Microsystems, Inc.
 * Copyright (c) 1995 Ilya Zakharevich.
 *
 * See the file "license.terms" for information on usage and redistribution
 * of this file, and for a DISCLAIMER OF ALL WARRANTIES.
 *
 * SCCS: @(#) tkText.c 1.90 96/04/13 16:49:59
 */
#define NO_COREXT

static char sccsid[] = "@(#) tkText.c 1.82 95/08/21 11:46:27";

#include "default.h"
#include "tkPort.h"
#include "tkInt.h"

#ifdef MAC_TCL
#define Style TkStyle
#define DInfo TkDInfo
#endif

#include "tkText.h"

static char rcsid[] = "$Id: tkText.c,v 1.24 1996/03/20 21:27:06 ilya Exp $";

/*
 * Information used to parse text configuration options:
 */

static Tk_ConfigSpec configSpecs[] = {
    {TK_CONFIG_BORDER, "-background", "background", "Background",
	DEF_TEXT_BG_COLOR, Tk_Offset(TkText, border), TK_CONFIG_COLOR_ONLY},
    {TK_CONFIG_BORDER, "-background", "background", "Background",
	DEF_TEXT_BG_MONO, Tk_Offset(TkText, border), TK_CONFIG_MONO_ONLY},
    {TK_CONFIG_SYNONYM, "-bd", "borderWidth", (char *) NULL,
	(char *) NULL, 0, 0},
    {TK_CONFIG_SYNONYM, "-bg", "background", (char *) NULL,
	(char *) NULL, 0, 0},
    {TK_CONFIG_PIXELS, "-borderwidth", "borderWidth", "BorderWidth",
	DEF_TEXT_BORDER_WIDTH, Tk_Offset(TkText, borderWidth), 0},
    {TK_CONFIG_ACTIVE_CURSOR, "-cursor", "cursor", "Cursor",
	DEF_TEXT_CURSOR, Tk_Offset(TkText, cursor), TK_CONFIG_NULL_OK},
    {TK_CONFIG_BOOLEAN, "-exportselection", "exportSelection",
	"ExportSelection", DEF_TEXT_EXPORT_SELECTION,
	Tk_Offset(TkText, exportSelection), 0},
    {TK_CONFIG_SYNONYM, "-fg", "foreground", (char *) NULL,
	(char *) NULL, 0, 0},
    {TK_CONFIG_FONT, "-font", "font", "Font",
	DEF_TEXT_FONT, Tk_Offset(TkText, fontPtr), 0},
    {TK_CONFIG_COLOR, "-foreground", "foreground", "Foreground",
	DEF_TEXT_FG, Tk_Offset(TkText, fgColor), 0},
    {TK_CONFIG_INT, "-getflags", "getflags", "getFlags",
	0, Tk_Offset(TkText, getFlags), 0},
    {TK_CONFIG_PIXELS, "-height", "height", "Height",
	DEF_TEXT_HEIGHT, Tk_Offset(TkText, height), 0},
    {TK_CONFIG_COLOR, "-highlightbackground", "highlightBackground",
	"HighlightBackground", DEF_TEXT_HIGHLIGHT_BG,
	Tk_Offset(TkText, highlightBgColorPtr), 0},
    {TK_CONFIG_COLOR, "-highlightcolor", "highlightColor", "HighlightColor",
	DEF_TEXT_HIGHLIGHT, Tk_Offset(TkText, highlightColorPtr), 0},
    {TK_CONFIG_PIXELS, "-highlightthickness", "highlightThickness",
	"HighlightThickness",
	DEF_TEXT_HIGHLIGHT_WIDTH, Tk_Offset(TkText, highlightWidth), 0},
    {TK_CONFIG_BORDER, "-insertbackground", "insertBackground", "Foreground",
	DEF_TEXT_INSERT_BG, Tk_Offset(TkText, insertBorder), 0},
    {TK_CONFIG_PIXELS, "-insertborderwidth", "insertBorderWidth", "BorderWidth",
	DEF_TEXT_INSERT_BD_COLOR, Tk_Offset(TkText, insertBorderWidth),
	TK_CONFIG_COLOR_ONLY},
    {TK_CONFIG_PIXELS, "-insertborderwidth", "insertBorderWidth", "BorderWidth",
	DEF_TEXT_INSERT_BD_MONO, Tk_Offset(TkText, insertBorderWidth),
	TK_CONFIG_MONO_ONLY},
    {TK_CONFIG_INT, "-insertofftime", "insertOffTime", "OffTime",
	DEF_TEXT_INSERT_OFF_TIME, Tk_Offset(TkText, insertOffTime), 0},
    {TK_CONFIG_INT, "-insertontime", "insertOnTime", "OnTime",
	DEF_TEXT_INSERT_ON_TIME, Tk_Offset(TkText, insertOnTime), 0},
    {TK_CONFIG_PIXELS, "-insertwidth", "insertWidth", "InsertWidth",
	DEF_TEXT_INSERT_WIDTH, Tk_Offset(TkText, insertWidth), 0},
    {TK_CONFIG_PIXELS, "-padx", "padX", "Pad",
	DEF_TEXT_PADX, Tk_Offset(TkText, padX), 0},
    {TK_CONFIG_PIXELS, "-pady", "padY", "Pad",
	DEF_TEXT_PADY, Tk_Offset(TkText, padY), 0},
    {TK_CONFIG_RELIEF, "-relief", "relief", "Relief",
	DEF_TEXT_RELIEF, Tk_Offset(TkText, relief), 0},
    {TK_CONFIG_BORDER, "-selectbackground", "selectBackground", "Foreground",
	DEF_TEXT_SELECT_COLOR, Tk_Offset(TkText, selBorder),
	TK_CONFIG_COLOR_ONLY},
    {TK_CONFIG_BORDER, "-selectbackground", "selectBackground", "Foreground",
	DEF_TEXT_SELECT_MONO, Tk_Offset(TkText, selBorder),
	TK_CONFIG_MONO_ONLY},
    {TK_CONFIG_STRING, "-selectborderwidth", "selectBorderWidth", "BorderWidth",
	DEF_TEXT_SELECT_BD_COLOR, Tk_Offset(TkText, selBdString),
	TK_CONFIG_COLOR_ONLY|TK_CONFIG_NULL_OK},
    {TK_CONFIG_STRING, "-selectborderwidth", "selectBorderWidth", "BorderWidth",
	DEF_TEXT_SELECT_BD_MONO, Tk_Offset(TkText, selBdString),
	TK_CONFIG_MONO_ONLY|TK_CONFIG_NULL_OK},
    {TK_CONFIG_COLOR, "-selectforeground", "selectForeground", "Background",
	DEF_TEXT_SELECT_FG_COLOR, Tk_Offset(TkText, selFgColorPtr),
	TK_CONFIG_COLOR_ONLY},
    {TK_CONFIG_COLOR, "-selectforeground", "selectForeground", "Background",
	DEF_TEXT_SELECT_FG_MONO, Tk_Offset(TkText, selFgColorPtr),
	TK_CONFIG_MONO_ONLY},
    {TK_CONFIG_BOOLEAN, "-setgrid", "setGrid", "SetGrid",
	DEF_TEXT_SET_GRID, Tk_Offset(TkText, setGrid), 0},
    {TK_CONFIG_PIXELS, "-spacing1", "spacing1", "Spacing",
	DEF_TEXT_SPACING1, Tk_Offset(TkText, spacing1),
	TK_CONFIG_DONT_SET_DEFAULT},
    {TK_CONFIG_PIXELS, "-spacing2", "spacing2", "Spacing",
	DEF_TEXT_SPACING2, Tk_Offset(TkText, spacing2),
	TK_CONFIG_DONT_SET_DEFAULT},
    {TK_CONFIG_PIXELS, "-spacing3", "spacing3", "Spacing",
	DEF_TEXT_SPACING3, Tk_Offset(TkText, spacing3),
	TK_CONFIG_DONT_SET_DEFAULT},
    {TK_CONFIG_UID, "-state", "state", "State",
	DEF_TEXT_STATE, Tk_Offset(TkText, state), 0},
    {TK_CONFIG_LANGARG, "-tabs", "tabs", "Tabs",
	DEF_TEXT_TABS, Tk_Offset(TkText, tabOptionString), TK_CONFIG_NULL_OK},
    {TK_CONFIG_STRING, "-takefocus", "takeFocus", "TakeFocus",
	DEF_TEXT_TAKE_FOCUS, Tk_Offset(TkText, takeFocus),
	TK_CONFIG_NULL_OK},
    {TK_CONFIG_INT, "-width", "width", "Width",
	DEF_TEXT_WIDTH, Tk_Offset(TkText, width), 0},
    {TK_CONFIG_UID, "-wrap", "wrap", "Wrap",
	DEF_TEXT_WRAP, Tk_Offset(TkText, wrapMode), 0},
    {TK_CONFIG_CALLBACK, "-xscrollcommand", "xScrollCommand", "ScrollCommand",
	DEF_TEXT_XSCROLL_COMMAND, Tk_Offset(TkText, xScrollCmd),
	TK_CONFIG_NULL_OK},
    {TK_CONFIG_CALLBACK, "-yscrollcommand", "yScrollCommand", "ScrollCommand",
	DEF_TEXT_YSCROLL_COMMAND, Tk_Offset(TkText, yScrollCmd),
	TK_CONFIG_NULL_OK},
    {TK_CONFIG_END, (char *) NULL, (char *) NULL, (char *) NULL,
	(char *) NULL, 0, 0}
};

/*
 * Tk_Uid's used to represent text states:
 */

Tk_Uid tkTextCharUid = NULL;
Tk_Uid tkTextDisabledUid = NULL;
Tk_Uid tkTextNoneUid = NULL;
Tk_Uid tkTextNormalUid = NULL;
Tk_Uid tkTextWordUid = NULL;

/*
 * Boolean variable indicating whether or not special debugging code
 * should be executed.
 */

int tkTextDebug = 0;

/*
 * Forward declarations for procedures defined later in this file:
 */

static int		ConfigureText _ANSI_ARGS_((Tcl_Interp *interp,
			    TkText *textPtr, int argc, char **argv, int flags));
static int		DeleteChars _ANSI_ARGS_((TkText *textPtr,
			    char *index1String, char *index2String));
static void		DestroyText _ANSI_ARGS_((char *memPtr));
static void		InsertChars _ANSI_ARGS_((TkText *textPtr,
			    TkTextIndex *indexPtr, char *string));
static void		TextBlinkProc _ANSI_ARGS_((ClientData clientData));
static void		TextCmdDeletedProc _ANSI_ARGS_((
			    ClientData clientData));
static void		TextEventProc _ANSI_ARGS_((ClientData clientData,
			    XEvent *eventPtr));
static int		TextFetchSelection _ANSI_ARGS_((ClientData clientData,
			    int offset, char *buffer, int maxBytes));
static int		TextSearchCmd _ANSI_ARGS_((TkText *textPtr,
			    Tcl_Interp *interp, int argc, char **argv));
static int		TextWidgetCmd _ANSI_ARGS_((ClientData clientData,
			    Tcl_Interp *interp, int argc, char **argv));
static void		DeleteBlock _ANSI_ARGS_((TkText *textPtr,
			    TkTextBlock *blockPtr));
static int		TextDumpCmd _ANSI_ARGS_((TkText *textPtr,
			    Tcl_Interp *interp, int argc, char **argv));
static void		DumpLine _ANSI_ARGS_((Tcl_Interp *interp, 
			    TkText *textPtr, int what, TkTextLine *linePtr,
			    int start, int end, int lineno, LangCallback *command));
static int		DumpSegment _ANSI_ARGS_((Tcl_Interp *interp, char *key,
			    char *value, LangCallback *command, int lineno, int offset,
			    int what));


/*
 *--------------------------------------------------------------
 *
 * Tk_TextCmd --
 *
 *	This procedure is invoked to process the "text" Tcl command.
 *	See the user documentation for details on what it does.
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	See the user documentation.
 *
 *--------------------------------------------------------------
 */

int
Tk_TextCmd(clientData, interp, argc, argv)
    ClientData clientData;	/* Main window associated with
				 * interpreter. */
    Tcl_Interp *interp;		/* Current interpreter. */
    int argc;			/* Number of arguments. */
    char **argv;		/* Argument strings. */
{
    Tk_Window tkwin = (Tk_Window) clientData;
    Tk_Window new;
    register TkText *textPtr;
    TkTextIndex startIndex;

    if (argc < 2) {
	Tcl_AppendResult(interp, "wrong # args: should be \"",
		argv[0], " pathName ?options?\"", (char *) NULL);
	return TCL_ERROR;
    }

    /*
     * Perform once-only initialization:
     */

    if (tkTextNormalUid == NULL) {
	tkTextCharUid = Tk_GetUid("char");
	tkTextDisabledUid = Tk_GetUid("disabled");
	tkTextNoneUid = Tk_GetUid("none");
	tkTextNormalUid = Tk_GetUid("normal");
	tkTextWordUid = Tk_GetUid("word");
    }

    /*
     * Create the window.
     */

    new = Tk_CreateWindowFromPath(interp, tkwin, argv[1], (char *) NULL);
    if (new == NULL) {
	return TCL_ERROR;
    }

    textPtr = (TkText *) ckalloc(sizeof(TkText));
    textPtr->tkwin = new;
    textPtr->display = Tk_Display(new);
    textPtr->interp = interp;
    textPtr->widgetCmd = Tcl_CreateCommand(interp,
	    Tk_PathName(textPtr->tkwin), TextWidgetCmd,
	    (ClientData) textPtr, TextCmdDeletedProc);
    textPtr->tree = TkBTreeCreate(textPtr);
    Tcl_InitHashTable(&textPtr->tagTable, TCL_STRING_KEYS);
    textPtr->numTags = 0;
    Tcl_InitHashTable(&textPtr->markTable, TCL_STRING_KEYS);
    Tcl_InitHashTable(&textPtr->windowTable, TCL_STRING_KEYS);
    Tcl_InitHashTable(&textPtr->blockTable, TCL_STRING_KEYS);
    textPtr->numDLines = 0;
    textPtr->dlinePtrs = NULL;
    textPtr->state = tkTextNormalUid;
    textPtr->border = NULL;
    textPtr->borderWidth = 0;
    textPtr->padX = 0;
    textPtr->padY = 0;
    textPtr->relief = TK_RELIEF_FLAT;
    textPtr->highlightWidth = 0;
    textPtr->highlightBgColorPtr = NULL;
    textPtr->highlightColorPtr = NULL;
    textPtr->cursor = None;
    textPtr->fgColor = NULL;
    textPtr->fontPtr = NULL;
    textPtr->charWidth = 1;
    textPtr->spacing1 = 0;
    textPtr->spacing2 = 0;
    textPtr->spacing3 = 0;
    textPtr->tabOptionString = NULL;
    textPtr->tabArrayPtr = NULL;
    textPtr->wrapMode = tkTextCharUid;
    textPtr->width = 0;
    textPtr->height = 0;
    textPtr->setGrid = 0;
    textPtr->prevWidth = Tk_Width(new);
    textPtr->prevHeight = Tk_Height(new);
    TkTextCreateDInfo(textPtr);
    TkTextMakeIndex(textPtr->tree, 0, 0, &startIndex);
    TkTextSetYView(textPtr, &startIndex, 0);
    textPtr->selTagPtr = NULL;
    textPtr->selBorder = NULL;
    textPtr->selBdString = NULL;
    textPtr->selFgColorPtr = NULL;
    textPtr->exportSelection = 1;
    textPtr->abortSelections = 0;
    textPtr->insertMarkPtr = NULL;
    textPtr->insertBorder = NULL;
    textPtr->insertWidth = 0;
    textPtr->insertBorderWidth = 0;
    textPtr->insertOnTime = 0;
    textPtr->insertOffTime = 0;
    textPtr->insertBlinkHandler = (Tcl_TimerToken) NULL;
    textPtr->bindingTable = NULL;
    textPtr->currentMarkPtr = NULL;
    textPtr->pickEvent.type = LeaveNotify;
    textPtr->pickEvent.xcrossing.x = 0;
    textPtr->pickEvent.xcrossing.y = 0;
    textPtr->numCurTags = 0;
    textPtr->curTagArrayPtr = NULL;
    textPtr->takeFocus = NULL;
    textPtr->xScrollCmd = NULL;
    textPtr->yScrollCmd = NULL;
    textPtr->getFlags = 0;
    textPtr->flags = 0;

    /*
     * Create the "sel" tag and the "current" and "insert" marks.
     */

    textPtr->selTagPtr = TkTextCreateTag(textPtr, "sel");
    textPtr->selTagPtr->reliefString = (char *) ckalloc(7);
    strcpy(textPtr->selTagPtr->reliefString, "raised");
    textPtr->selTagPtr->relief = TK_RELIEF_RAISED;
    textPtr->currentMarkPtr = TkTextSetMark(textPtr, "current", &startIndex);
    textPtr->insertMarkPtr = TkTextSetMark(textPtr, "insert", &startIndex);

    Tk_SetClass(new, TEXT_Class);
    Tk_CreateEventHandler(textPtr->tkwin,
	    ExposureMask|StructureNotifyMask|FocusChangeMask,
	    TextEventProc, (ClientData) textPtr);
    Tk_CreateEventHandler(textPtr->tkwin, KeyPressMask|KeyReleaseMask
	    |ButtonPressMask|ButtonReleaseMask|EnterWindowMask
	    |LeaveWindowMask|PointerMotionMask, TkTextBindProc,
	    (ClientData) textPtr);
    Tk_CreateSelHandler(textPtr->tkwin, XA_PRIMARY, XA_STRING,
	    TextFetchSelection, (ClientData) textPtr, XA_STRING);
    if (ConfigureText(interp, textPtr, argc-2, argv+2, 0) != TCL_OK) {
	Tk_DestroyWindow(textPtr->tkwin);
	return TCL_ERROR;
    }
    interp->result = Tk_PathName(textPtr->tkwin);

    return TCL_OK;
}

/*
 *--------------------------------------------------------------
 *
 * TextWidgetCmd --
 *
 *	This procedure is invoked to process the Tcl command
 *	that corresponds to a text widget.  See the user
 *	documentation for details on what it does.
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	See the user documentation.
 *
 *--------------------------------------------------------------
 */

static int
TextWidgetCmd(clientData, interp, argc, argv)
    ClientData clientData;	/* Information about text widget. */
    Tcl_Interp *interp;		/* Current interpreter. */
    int argc;			/* Number of arguments. */
    char **argv;		/* Argument strings. */
{
    register TkText *textPtr = (TkText *) clientData;
    int result = TCL_OK;
    size_t length;
    int c;
    TkTextIndex index1, index2;

    if (argc < 2) {
	Tcl_AppendResult(interp, "wrong # args: should be \"",
		argv[0], " option ?arg arg ...?\"", (char *) NULL);
	return TCL_ERROR;
    }
    Tcl_Preserve((ClientData) textPtr);
    c = argv[1][0];
    length = strlen(argv[1]);
    if ((c == 'b') && (strncmp(argv[1], "bbox", length) == 0) 
	&& (length >= 2)) {
	int x, y, width, height;

	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " bbox index\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextCharBbox(textPtr, &index1, &x, &y, &width, &height) == 0) {
	    sprintf(interp->result, "%d %d %d %d", x, y, width, height);
	}
    } else if ((c == 'b') && (strncmp(argv[1], "block", length) == 0)
	    && (length >= 2)) {
	result = TkTextBlockCmd(textPtr, interp, argc, argv);
    } else if ((c == 'c') && (strncmp(argv[1], "cget", length) == 0)
	    && (length >= 2)) {
	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " cget option\"",
		    (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	result = Tk_ConfigureValue(interp, textPtr->tkwin, configSpecs,
		(char *) textPtr, argv[2], 0);
    } else if ((c == 'c') && (strncmp(argv[1], "compare", length) == 0)
	    && (length >= 3)) {
	int relation, value;
	char *p;

	if (argc != 5) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " compare index1 op index2\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if ((TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK)
		|| (TkTextGetIndex(interp, textPtr, argv[4], &index2)
		!= TCL_OK)) {
	    result = TCL_ERROR;
	    goto done;
	}
	relation = TkTextIndexCmp(&index1, &index2);
	p = argv[3];
	if (p[0] == '<') {
		value = (relation < 0);
	    if ((p[1] == '=') && (p[2] == 0)) {
		value = (relation <= 0);
	    } else if (p[1] != 0) {
		compareError:
		Tcl_AppendResult(interp, "bad comparison operator \"",
			argv[3], "\": must be <, <=, ==, >=, >, or !=",
			(char *) NULL);
		result = TCL_ERROR;
		goto done;
	    }
	} else if (p[0] == '>') {
		value = (relation > 0);
	    if ((p[1] == '=') && (p[2] == 0)) {
		value = (relation >= 0);
	    } else if (p[1] != 0) {
		goto compareError;
	    }
	} else if ((p[0] == '=') && (p[1] == '=') && (p[2] == 0)) {
	    value = (relation == 0);
	} else if ((p[0] == '!') && (p[1] == '=') && (p[2] == 0)) {
	    value = (relation != 0);
	} else {
	    goto compareError;
	}
	interp->result = (value) ? "1" : "0";
    } else if ((c == 'c') && (strncmp(argv[1], "configure", length) == 0)
	    && (length >= 3)) {
	if (argc == 2) {
	    result = Tk_ConfigureInfo(interp, textPtr->tkwin, configSpecs,
		    (char *) textPtr, (char *) NULL, 0);
	} else if (argc == 3) {
	    result = Tk_ConfigureInfo(interp, textPtr->tkwin, configSpecs,
		    (char *) textPtr, argv[2], 0);
	} else {
	    result = ConfigureText(interp, textPtr, argc-2, argv+2,
		    TK_CONFIG_ARGV_ONLY);
	}
    } else if ((c == 'd') && (strncmp(argv[1], "debug", length) == 0)
	    && (length >= 3)) {
	if (argc > 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " debug boolean\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (argc == 2) {
	    interp->result = (tkBTreeDebug) ? "1" : "0";
	} else {
	    if (Tcl_GetBoolean(interp, argv[2], &tkBTreeDebug) != TCL_OK) {
		result = TCL_ERROR;
		goto done;
	    }
	    tkTextDebug = tkBTreeDebug;
	}
    } else if ((c == 'd') && (strncmp(argv[1], "delete", length) == 0)
	    && (length >= 3)) {
	if ((argc != 3) && (argc != 4)) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " delete index1 ?index2?\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (textPtr->state == tkTextNormalUid) {
	    result = DeleteChars(textPtr, argv[2],
		    (argc == 4) ? argv[3] : (char *) NULL);
	}
    } else if ((c == 'd') && (strncmp(argv[1], "dlineinfo", length) == 0)
	    && (length >= 2)) {
	int x, y, width, height, base;

	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " dlineinfo index\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextDLineInfo(textPtr, &index1, &x, &y, &width, &height, &base)
		== 0) {
	    sprintf(interp->result, "%d %d %d %d %d", x, y, width,
		    height, base);
	}
    } else if ((c == 'g') && (strncmp(argv[1], "get", length) == 0)) {
        Tcl_DString dstring;
	TkTextLine *linePtr;
	int offset, dummy;

	if ((argc != 3) && (argc != 4)) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " get index1 ?index2?\"", (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}
	if (argc == 3) {
	    index2 = index1;
	    TkTextIndexForwChars(&index2, 1, &index2);
	} else if (TkTextGetIndex(interp, textPtr, argv[3], &index2)
		!= TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextIndexCmp(&index1, &index2) >= 0) {
	    goto done;
	}
	linePtr = index1.linePtr;
	offset = index1.charIndex; 
	Tcl_DStringInit(&dstring);
	while (linePtr != index2.linePtr) {
	  TkBTreeLineTextAppend(textPtr, linePtr, offset, -1, 
				(void*)&dstring, 
				textPtr->getFlags | TKT_GET_DSTRING, NULL);
	  offset = -1;			/* Report all of the rest */
	  linePtr = TkBTreeNextLine(linePtr);
	}
	TkBTreeLineTextAppend(textPtr, linePtr, offset, index2.charIndex,
			      (void*)&dstring, 
			      textPtr->getFlags | TKT_GET_DSTRING, NULL);
	Tcl_AppendResult(interp, dstring.string, (char *) NULL);
	Tcl_DStringFree(&dstring);
    } else if ((c == 'i') && (strncmp(argv[1], "index", length) == 0)
	    && (length >= 3)) {
        char buffer[80];
	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " index index\"",
		    (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}

	TkTextPrintIndex(&index1, buffer);
        Tcl_SetResult(interp,buffer,TCL_VOLATILE);
    } else if ((c == 'i') && (strncmp(argv[1], "insert", length) == 0)
	    && (length >= 3)) {
	int i, j, numTags;
	Arg *tagNames;
	TkTextTag **oldTagArrayPtr;

	if (argc < 4) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0],
		    " insert index chars ?tagList chars tagList ...?\"",
		    (char *) NULL);
	    result = TCL_ERROR;
	    goto done;
	}
	if (TkTextGetIndex(interp, textPtr, argv[2], &index1) != TCL_OK) {
	    result = TCL_ERROR;
	    goto done;
	}
	if (textPtr->state == tkTextNormalUid) {
	    for (j = 3;  j < argc; j += 2) {
		InsertChars(textPtr, &index1, argv[j]);
		if (argc > (j+1)) {
		    LangFreeProc *freeProc = NULL;
		    TkTextIndexForwChars(&index1, (int) strlen(argv[j]),
			    &index2);
		    oldTagArrayPtr = TkBTreeGetTags(&index1, &numTags);
		    if (oldTagArrayPtr != NULL) {
			for (i = 0; i < numTags; i++) {
			    TkBTreeTag(&index1, &index2, oldTagArrayPtr[i], 0);
			}
			ckfree((char *) oldTagArrayPtr);
		    }
		    if (Lang_SplitList(interp, args[j+1], &numTags, &tagNames, &freeProc)
			    != TCL_OK) {
			result = TCL_ERROR;
			goto done;
		    }
		    for (i = 0; i < numTags; i++) {
			TkBTreeTag(&index1, &index2,
				TkTextCreateTag(textPtr, LangString(tagNames[i])), 1);
		    }
		    if (freeProc)
			(*freeProc) (numTags, tagNames);
		    index1 = index2;
		}
	    }
	}
    } else if ((c == 'd') && (strncmp(argv[1], "dump", length) == 0)) {
	result = TextDumpCmd(textPtr, interp, argc, argv);
    } else if ((c == 'm') && (strncmp(argv[1], "mark", length) == 0)) {
	result = TkTextMarkCmd(textPtr, interp, argc, argv);
    } else if ((c == 's') && (strcmp(argv[1], "scan") == 0) && (length >= 2)) {
	result = TkTextScanCmd(textPtr, interp, argc, argv);
    } else if ((c == 's') && (strcmp(argv[1], "search") == 0)
	    && (length >= 3)) {
	result = TextSearchCmd(textPtr, interp, argc, argv);
    } else if ((c == 's') && (strcmp(argv[1], "see") == 0) && (length >= 3)) {
	result = TkTextSeeCmd(textPtr, interp, argc, argv);
    } else if ((c == 't') && (strcmp(argv[1], "tag") == 0)) {
	result = TkTextTagCmd(textPtr, interp, argc, argv);
    } else if ((c == 'w') && (strncmp(argv[1], "window", length) == 0)) {
	result = TkTextWindowCmd(textPtr, interp, argc, argv);
    } else if ((c == 'x') && (strncmp(argv[1], "xview", length) == 0)) {
	result = TkTextXviewCmd(textPtr, interp, argc, argv);
    } else if ((c == 'y') && (strncmp(argv[1], "yview", length) == 0)
	    && (length >= 2)) {
	result = TkTextYviewCmd(textPtr, interp, argc, argv);
    } else {
	Tcl_AppendResult(interp, "bad option \"", argv[1],
		"\": must be bbox, block, cget, compare, configure, debug, delete, ",
		"dlineinfo, get, index, insert, mark, scan, search, see, ",
		"tag, window, xview, or yview",
		(char *) NULL);
	result = TCL_ERROR;
    }

    done:
    Tcl_Release((ClientData) textPtr);
    return result;
}

/*
 *----------------------------------------------------------------------
 *
 * DestroyText --
 *
 *	This procedure is invoked by Tcl_EventuallyFree or Tcl_Release
 *	to clean up the internal structure of a text at a safe time
 *	(when no-one is using it anymore).
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	Everything associated with the text is freed up.
 *
 *----------------------------------------------------------------------
 */

static void
DestroyText(memPtr)
    char *memPtr;		/* Info about text widget. */
{
    register TkText *textPtr = (TkText *) memPtr;
    Tcl_HashSearch search;
    Tcl_HashEntry *hPtr;
    TkTextTag *tagPtr;
    TkTextBlock *blockPtr;

    /*
     * Free up all the stuff that requires special handling, then
     * let Tk_FreeOptions handle all the standard option-related
     * stuff.  Special note:  free up display-related information
     * before deleting the B-tree, since display-related stuff
     * may refer to stuff in the B-tree.
     *
     * In fact we have chicken and egg problem: blocks can refer to
     * DLines, and tree can refer to blocks. We delete blocks first,
     * and it looks like the block information is not used during
     * deletion of IBTree.
     */

    if (textPtr->dlinePtrs) {
      int i;

      for (i = 0; i < textPtr->numDLines; i++) {
	TkTextFreeDLine(textPtr, textPtr->dlinePtrs[i]);
      }
      ckfree((char*)textPtr->dlinePtrs);
    }
    TkTextFreeDInfo(textPtr);
    TkBTreeDestroy(textPtr->tree);
    for (hPtr = Tcl_FirstHashEntry(&textPtr->blockTable, &search);
	    hPtr != NULL; hPtr = Tcl_NextHashEntry(&search)) {
	DeleteBlock(textPtr, (TkTextBlock *) Tcl_GetHashValue(hPtr));
    }
    Tcl_DeleteHashTable(&textPtr->blockTable);
    for (hPtr = Tcl_FirstHashEntry(&textPtr->tagTable, &search);
	    hPtr != NULL; hPtr = Tcl_NextHashEntry(&search)) {
	tagPtr = (TkTextTag *) Tcl_GetHashValue(hPtr);
	TkTextFreeTag(textPtr, tagPtr);
    }
    Tcl_DeleteHashTable(&textPtr->tagTable);
    for (hPtr = Tcl_FirstHashEntry(&textPtr->markTable, &search);
	    hPtr != NULL; hPtr = Tcl_NextHashEntry(&search)) {
	ckfree((char *) Tcl_GetHashValue(hPtr));
    }
    Tcl_DeleteHashTable(&textPtr->markTable);
    if (textPtr->tabArrayPtr != NULL) {
	ckfree((char *) textPtr->tabArrayPtr);
    }
    if (textPtr->insertBlinkHandler != NULL) {
	Tcl_DeleteTimerHandler(textPtr->insertBlinkHandler);
    }
    if (textPtr->bindingTable != NULL) {
	Tk_DeleteBindingTable(textPtr->bindingTable);
    }

    /*
     * NOTE: do NOT free up selBorder, selBdString, or selFgColorPtr:
     * they are duplicates of information in the "sel" tag, which was
     * freed up as part of deleting the tags above.
     */

    textPtr->selBorder = NULL;
    textPtr->selBdString = NULL;
    textPtr->selFgColorPtr = NULL;
    Tk_FreeOptions(configSpecs, (char *) textPtr, textPtr->display, 0);
    ckfree((char *) textPtr);
}

/*
 *----------------------------------------------------------------------
 *
 * ConfigureText --
 *
 *	This procedure is called to process an argv/argc list, plus
 *	the Tk option database, in order to configure (or
 *	reconfigure) a text widget.
 *
 * Results:
 *	The return value is a standard Tcl result.  If TCL_ERROR is
 *	returned, then interp->result contains an error message.
 *
 * Side effects:
 *	Configuration information, such as text string, colors, font,
 *	etc. get set for textPtr;  old resources get freed, if there
 *	were any.
 *
 *----------------------------------------------------------------------
 */

static int
ConfigureText(interp, textPtr, argc, argv, flags)
    Tcl_Interp *interp;		/* Used for error reporting. */
    register TkText *textPtr;	/* Information about widget;  may or may
				 * not already have values for some fields. */
    int argc;			/* Number of valid entries in argv. */
    char **argv;		/* Arguments. */
    int flags;			/* Flags to pass to Tk_ConfigureWidget. */
{
    int oldExport = textPtr->exportSelection;
    int charHeight;

    if (Tk_ConfigureWidget(interp, textPtr->tkwin, configSpecs,
	    argc, argv, (char *) textPtr, flags) != TCL_OK) {
	return TCL_ERROR;
    }

    /*
     * A few other options also need special processing, such as parsing
     * the geometry and setting the background from a 3-D border.
     */

    if ((textPtr->state != tkTextNormalUid)
	    && (textPtr->state != tkTextDisabledUid)) {
	Tcl_AppendResult(interp, "bad state value \"", textPtr->state,
		"\": must be normal or disabled", (char *) NULL);
	textPtr->state = tkTextNormalUid;
	return TCL_ERROR;
    }

    if ((textPtr->wrapMode != tkTextCharUid)
	    && (textPtr->wrapMode != tkTextNoneUid)
	    && (textPtr->wrapMode != tkTextWordUid)) {
	Tcl_AppendResult(interp, "bad wrap mode \"", textPtr->wrapMode,
		"\": must be char, none, or word", (char *) NULL);
	textPtr->wrapMode = tkTextCharUid;
	return TCL_ERROR;
    }

    Tk_SetBackgroundFromBorder(textPtr->tkwin, textPtr->border);

    /*
     * Don't allow negative spacings.
     */

    if (textPtr->spacing1 < 0) {
	textPtr->spacing1 = 0;
    }
    if (textPtr->spacing2 < 0) {
	textPtr->spacing2 = 0;
    }
    if (textPtr->spacing3 < 0) {
	textPtr->spacing3 = 0;
    }

    /*
     * Parse tab stops.
     */

    if (textPtr->tabArrayPtr != NULL) {
	ckfree((char *) textPtr->tabArrayPtr);
	textPtr->tabArrayPtr = NULL;
    }
    if (textPtr->tabOptionString != NULL) {
	textPtr->tabArrayPtr = TkTextGetTabs(interp, textPtr->tkwin,
		textPtr->tabOptionString);
	if (textPtr->tabArrayPtr == NULL) {
	    Tcl_AddErrorInfo(interp,"\n    (while processing -tabs option)");
	    return TCL_ERROR;
	}
    }

    /*
     * Make sure that configuration options are properly mirrored
     * between the widget record and the "sel" tags.  NOTE: we don't
     * have to free up information during the mirroring;  old
     * information was freed when it was replaced in the widget
     * record.
     */

    textPtr->selTagPtr->border = textPtr->selBorder;
    if (textPtr->selTagPtr->bdString != textPtr->selBdString) {
	textPtr->selTagPtr->bdString = textPtr->selBdString;
	if (textPtr->selBdString != NULL) {
	    if (Tk_GetPixels(interp, textPtr->tkwin, textPtr->selBdString,
		    &textPtr->selTagPtr->borderWidth) != TCL_OK) {
		return TCL_ERROR;
	    }
	    if (textPtr->selTagPtr->borderWidth < 0) {
		textPtr->selTagPtr->borderWidth = 0;
	    }
	}
    }
    textPtr->selTagPtr->fgColor = textPtr->selFgColorPtr;
    textPtr->selTagPtr->affectsDisplay = 0;
    if ((textPtr->selTagPtr->border != NULL)
	    || (textPtr->selTagPtr->bdString != NULL)
	    || (textPtr->selTagPtr->reliefString != NULL)
	    || (textPtr->selTagPtr->bgStipple != None)
	    || (textPtr->selTagPtr->fgColor != NULL)
	    || (textPtr->selTagPtr->fontPtr != None)
	    || (textPtr->selTagPtr->fgStipple != None)
	    || (textPtr->selTagPtr->justifyString != NULL)
	    || (textPtr->selTagPtr->lMargin1String != NULL)
	    || (textPtr->selTagPtr->lMargin2String != NULL)
	    || (textPtr->selTagPtr->offsetString != NULL)
	    || (textPtr->selTagPtr->overstrikeString != NULL)
	    || (textPtr->selTagPtr->rMarginString != NULL)
	    || (textPtr->selTagPtr->spacing1String != NULL)
	    || (textPtr->selTagPtr->spacing2String != NULL)
	    || (textPtr->selTagPtr->spacing3String != NULL)
	    || (textPtr->selTagPtr->tabString != NULL)
	    || (textPtr->selTagPtr->underlineString != NULL)
	    || (textPtr->selTagPtr->wrapMode != NULL)) {
	textPtr->selTagPtr->affectsDisplay = 1;
    }
    TkTextRedrawTag(textPtr, (TkTextIndex *) NULL, (TkTextIndex *) NULL,
	    textPtr->selTagPtr, 1);

    /*
     * Claim the selection if we've suddenly started exporting it and there
     * are tagged characters.
     */

    if (textPtr->exportSelection && (!oldExport)) {
	TkTextSearch search;
	TkTextIndex first, last;

	TkTextMakeIndex(textPtr->tree, 0, 0, &first);
	TkTextMakeIndex(textPtr->tree,
		TkBTreeNumLines(textPtr->tree), 0, &last);
	TkBTreeStartSearch(&first, &last, textPtr->selTagPtr, &search);
	if (TkBTreeCharTagged(&first, textPtr->selTagPtr)
		|| TkBTreeNextTag(&search)) {
	    Tk_OwnSelection(textPtr->tkwin, XA_PRIMARY, TkTextLostSelection,
		    (ClientData) textPtr);
	    textPtr->flags |= GOT_SELECTION;
	}
    }

    /*
     * Register the desired geometry for the window, and arrange for
     * the window to be redisplayed.
     */

    if (textPtr->width <= 0) {
	textPtr->width = 1;
    }
    if (textPtr->height <= 0) {
	textPtr->height = 1;
    }
    textPtr->charWidth = XTextWidth(textPtr->fontPtr, "0", 1);
    if (textPtr->charWidth <= 0) {
	textPtr->charWidth = 1;
    }
    charHeight = (textPtr->fontPtr->ascent + textPtr->fontPtr->descent);
    Tk_GeometryRequest(textPtr->tkwin,
	    textPtr->width * textPtr->charWidth + 2*textPtr->borderWidth
		    + 2*textPtr->padX + 2*textPtr->highlightWidth,
	    textPtr->height * charHeight + 2*textPtr->borderWidth
		    + 2*textPtr->padY + 2*textPtr->highlightWidth);
    Tk_SetInternalBorder(textPtr->tkwin,
	    textPtr->borderWidth + textPtr->highlightWidth);
    if (textPtr->setGrid) {
	Tk_SetGrid(textPtr->tkwin, textPtr->width, textPtr->height,
		textPtr->charWidth, charHeight);
    } else {
	Tk_UnsetGrid(textPtr->tkwin);
    }

    TkTextRelayoutWindow(textPtr);
    return TCL_OK;
}

/*
 *--------------------------------------------------------------
 *
 * TextEventProc --
 *
 *	This procedure is invoked by the Tk dispatcher on
 *	structure changes to a text.  For texts with 3D
 *	borders, this procedure is also invoked for exposures.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	When the window gets deleted, internal structures get
 *	cleaned up.  When it gets exposed, it is redisplayed.
 *
 *--------------------------------------------------------------
 */

static void
TextEventProc(clientData, eventPtr)
    ClientData clientData;	/* Information about window. */
    register XEvent *eventPtr;	/* Information about event. */
{
    register TkText *textPtr = (TkText *) clientData;
    TkTextIndex index, index2;

    if (eventPtr->type == Expose) {
	TkTextRedrawRegion(textPtr, eventPtr->xexpose.x,
		eventPtr->xexpose.y, eventPtr->xexpose.width,
		eventPtr->xexpose.height);
    } else if (eventPtr->type == ConfigureNotify) {
	if ((textPtr->prevWidth != Tk_Width(textPtr->tkwin))
		|| (textPtr->prevHeight != Tk_Height(textPtr->tkwin))) {
	    TkTextRelayoutWindow(textPtr);
	    textPtr->prevWidth = Tk_Width(textPtr->tkwin);
	    textPtr->prevHeight = Tk_Height(textPtr->tkwin);
	}
    } else if (eventPtr->type == DestroyNotify) {
	if (textPtr->setGrid) {
	    Tk_UnsetGrid(textPtr->tkwin);
	}
	if (textPtr->tkwin != NULL) {
	    textPtr->tkwin = NULL;
	    Tcl_DeleteCommand(textPtr->interp,
		    Tcl_GetCommandName(textPtr->interp,
		    textPtr->widgetCmd));
	}
	Tcl_EventuallyFree((ClientData) textPtr, DestroyText);
    } else if ((eventPtr->type == FocusIn) || (eventPtr->type == FocusOut)) {
	if (eventPtr->xfocus.detail != NotifyInferior) {
	    Tcl_DeleteTimerHandler(textPtr->insertBlinkHandler);
	    if (eventPtr->type == FocusIn) {
		textPtr->flags |= GOT_FOCUS | INSERT_ON;
		if (textPtr->insertOffTime != 0) {
		    textPtr->insertBlinkHandler = Tcl_CreateTimerHandler(
			    textPtr->insertOnTime, TextBlinkProc,
			    (ClientData) textPtr);
		}
	    } else {
		textPtr->flags &= ~(GOT_FOCUS | INSERT_ON);
		textPtr->insertBlinkHandler = (Tcl_TimerToken) NULL;
	    }
	    TkTextMarkSegToIndex(textPtr, textPtr->insertMarkPtr, &index);
	    TkTextIndexForwChars(&index, 1, &index2);
	    TkTextChanged(textPtr, &index, &index2);
	    if (textPtr->highlightWidth > 0) {
		TkTextRedrawRegion(textPtr, 0, 0, textPtr->highlightWidth,
			textPtr->highlightWidth);
	    }
	}
    }
}

/*
 *----------------------------------------------------------------------
 *
 * TextCmdDeletedProc --
 *
 *	This procedure is invoked when a widget command is deleted.  If
 *	the widget isn't already in the process of being destroyed,
 *	this command destroys it.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	The widget is destroyed.
 *
 *----------------------------------------------------------------------
 */

static void
TextCmdDeletedProc(clientData)
    ClientData clientData;	/* Pointer to widget record for widget. */
{
    TkText *textPtr = (TkText *) clientData;
    Tk_Window tkwin = textPtr->tkwin;

    /*
     * This procedure could be invoked either because the window was
     * destroyed and the command was then deleted (in which case tkwin
     * is NULL) or because the command was deleted, and then this procedure
     * destroys the widget.
     */

    if (tkwin != NULL) {
	textPtr->tkwin = NULL;
	Tk_DestroyWindow(tkwin);
    }
}

/*
 *----------------------------------------------------------------------
 *
 * InsertChars --
 *
 *	This procedure implements most of the functionality of the
 *	"insert" widget command.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	The characters in "string" get added to the text just before
 *	the character indicated by "indexPtr".
 *
 *----------------------------------------------------------------------
 */

static void
InsertChars(textPtr, indexPtr, string)
    TkText *textPtr;		/* Overall information about text widget. */
    TkTextIndex *indexPtr;	/* Where to insert new characters.  May be
				 * modified and/or invalidated. */
    char *string;		/* Null-terminated string containing new
				 * information to add to text. */
{
    int lineIndex, resetView, offset;
    TkTextIndex newTop;

    /*
     * Don't allow insertions on the last (dummy) line of the text.
     */

    lineIndex = TkBTreeLineIndex(indexPtr->linePtr);
    if (lineIndex == TkBTreeNumLines(textPtr->tree)) {
	lineIndex--;
	TkTextMakeIndex(textPtr->tree, lineIndex, 1000000, indexPtr);
    }

    /*
     * Notify the display module that lines are about to change, then do
     * the insertion.  If the insertion occurs on the top line of the
     * widget (textPtr->topIndex), then we have to recompute topIndex
     * after the insertion, since the insertion could invalidate it.
     */

    resetView = offset = 0;
    if (indexPtr->linePtr == textPtr->topIndex.linePtr) {
	resetView = 1;
	offset = textPtr->topIndex.charIndex;
	if (offset > indexPtr->charIndex) {
	    offset += strlen(string);
	}
    }
    TkTextChanged(textPtr, indexPtr, indexPtr);
    TkBTreeInsertChars(indexPtr, string);
    if (resetView) {
	TkTextMakeIndex(textPtr->tree, lineIndex, 0, &newTop);
	TkTextIndexForwChars(&newTop, offset, &newTop);
	TkTextSetYView(textPtr, &newTop, 0);
    }

    /*
     * Invalidate any selection retrievals in progress.
     */

    textPtr->abortSelections = 1;
}

/*
 *----------------------------------------------------------------------
 *
 * DeleteChars --
 *
 *	This procedure implements most of the functionality of the
 *	"delete" widget command.
 *
 * Results:
 *	Returns a standard Tcl result, and leaves an error message
 *	in textPtr->interp if there is an error.
 *
 * Side effects:
 *	Characters get deleted from the text.
 *
 *----------------------------------------------------------------------
 */

static int
DeleteChars(textPtr, index1String, index2String)
    TkText *textPtr;		/* Overall information about text widget. */
    char *index1String;		/* String describing location of first
				 * character to delete. */
    char *index2String;		/* String describing location of last
				 * character to delete.  NULL means just
				 * delete the one character given by
				 * index1String. */
{
    int line1, line2, line, charIndex, resetView;
    TkTextIndex index1, index2;

    /*
     * Parse the starting and stopping indices.
     */

    if (TkTextGetIndex(textPtr->interp, textPtr, index1String, &index1)
	    != TCL_OK) {
	return TCL_ERROR;
    }
    if (index2String != NULL) {
	if (TkTextGetIndex(textPtr->interp, textPtr, index2String, &index2)
		!= TCL_OK) {
	    return TCL_ERROR;
	}
    } else {
	index2 = index1;
	TkTextIndexForwChars(&index2, 1, &index2);
    }

    /*
     * Make sure there's really something to delete.
     */

    if (TkTextIndexCmp(&index1, &index2) >= 0) {
	return TCL_OK;
    }

    /*
     * The code below is ugly, but it's needed to make sure there
     * is always a dummy empty line at the end of the text.  If the
     * final newline of the file (just before the dummy line) is being
     * deleted, then back up index to just before the newline.  If
     * there is a newline just before the first character being deleted,
     * then back up the first index too, so that an even number of lines
     * gets deleted.  Furthermore, remove any tags that are present on
     * the newline that isn't going to be deleted after all (this simulates
     * deleting the newline and then adding a "clean" one back again).
     */

    line1 = TkBTreeLineIndex(index1.linePtr);
    line2 = TkBTreeLineIndex(index2.linePtr);
    if (line2 == TkBTreeNumLines(textPtr->tree)) {
	TkTextTag **arrayPtr;
	int arraySize, i;
	TkTextIndex oldIndex2;

	oldIndex2 = index2;
	TkTextIndexBackChars(&oldIndex2, 1, &index2);
	line2--;
	if ((index1.charIndex == 0) && (line1 != 0)) {
	    TkTextIndexBackChars(&index1, 1, &index1);
	    line1--;
	}
	arrayPtr = TkBTreeGetTags(&index2, &arraySize);
	if (arrayPtr != NULL) {
	    for (i = 0; i < arraySize; i++) {
		TkBTreeTag(&index2, &oldIndex2, arrayPtr[i], 0);
	    }
	    ckfree((char *) arrayPtr);
	}
    }

    /*
     * Tell the display what's about to happen so it can discard
     * obsolete display information, then do the deletion.  Also,
     * if the deletion involves the top line on the screen, then
     * we have to reset the view (the deletion will invalidate
     * textPtr->topIndex).  Compute what the new first character
     * will be, then do the deletion, then reset the view.
     */

    TkTextChanged(textPtr, &index1, &index2);
    resetView = line = charIndex = 0;
    if (TkTextIndexCmp(&index2, &textPtr->topIndex) >= 0) {
	if (TkTextIndexCmp(&index1, &textPtr->topIndex) <= 0) {
	    /*
	     * Deletion range straddles topIndex: use the beginning
	     * of the range as the new topIndex.
	     */

	    resetView = 1;
	    line = line1;
	    charIndex = index1.charIndex;
	} else if (index1.linePtr == textPtr->topIndex.linePtr) {
	    /*
	     * Deletion range starts on top line but after topIndex.
	     * Use the current topIndex as the new one.
	     */

	    resetView = 1;
	    line = line1;
	    charIndex = textPtr->topIndex.charIndex;
	}
    } else if (index2.linePtr == textPtr->topIndex.linePtr) {
	/*
	 * Deletion range ends on top line but before topIndex.
	 * Figure out what will be the new character index for
	 * the character currently pointed to by topIndex.
	 */

	resetView = 1;
	line = line2;
	charIndex = textPtr->topIndex.charIndex;
	if (index1.linePtr != index2.linePtr) {
	    charIndex -= index2.charIndex;
	} else {
	    charIndex -= (index2.charIndex - index1.charIndex);
	}
    }
    TkBTreeDeleteChars(&index1, &index2, 1, 1);
    if (resetView) {
	TkTextMakeIndex(textPtr->tree, line, charIndex, &index1);
	TkTextSetYView(textPtr, &index1, 0);
    }

    /*
     * Invalidate any selection retrievals in progress.
     */

    textPtr->abortSelections = 1;

    return TCL_OK;
}

/*
 *----------------------------------------------------------------------
 *
 * TextFetchSelection --
 *
 *	This procedure is called back by Tk when the selection is
 *	requested by someone.  It returns part or all of the selection
 *	in a buffer provided by the caller.
 *
 * Results:
 *	The return value is the number of non-NULL bytes stored
 *	at buffer.  Buffer is filled (or partially filled) with a
 *	NULL-terminated string containing part or all of the selection,
 *	as given by offset and maxBytes.
 *
 * Side effects:
 *	None.
 *
 *----------------------------------------------------------------------
 */

static int
TextFetchSelection(clientData, offset, buffer, maxBytes)
    ClientData clientData;		/* Information about text widget. */
    int offset;				/* Offset within selection of first
					 * character to be returned. */
    char *buffer;			/* Location in which to place
					 * selection. */
    int maxBytes;			/* Maximum number of bytes to place
					 * at buffer, not including terminating
					 * NULL character. */
{
    register TkText *textPtr = (TkText *) clientData;
    TkTextIndex eof;
    int count, chunkSize, offsetInSeg, startOff, endOff;
    TkTextSearch search;
    TkTextSegment *segPtr;
    TkTextLine *linePtr;

    if (!textPtr->exportSelection) {
	return -1;
    }

    /*
     * Find the beginning of the next range of selected text.  Note:  if
     * the selection is being retrieved in multiple pieces (offset != 0)
     * and some modification has been made to the text that affects the
     * selection then reject the selection request (make 'em start over
     * again).
     */

    if (offset == 0) {
	TkTextMakeIndex(textPtr->tree, 0, 0, &textPtr->selIndex);
	textPtr->abortSelections = 0;
	textPtr->selRest = 0;
    } else if (textPtr->abortSelections) {
	return 0;
    } else {
      TkTextIndexToExternalIndex(textPtr->tree, 
				 &textPtr->selIndex, &textPtr->selIndex);
    }
    TkTextMakeIndex(textPtr->tree, TkBTreeNumLines(textPtr->tree), 0, &eof);
    TkBTreeStartSearch(&textPtr->selIndex, &eof, textPtr->selTagPtr, &search);
    if (!TkBTreeCharTagged(&textPtr->selIndex, textPtr->selTagPtr)) {
	if (!TkBTreeNextTag(&search)) {
	    if (offset == 0) {
		return -1;
	    } else {
		return 0;
	    }
	}
	textPtr->selIndex = search.extIndex;
    }

    /*
     * Each iteration through the outer loop below scans one selected range.
     * Each iteration through the inner loop scans one segment in the
     * selected range.
     */

    count = 0;
    if (textPtr->selRest) {	/* Need to skip first several characters. */
        Tcl_DString dString;
	int i;
	char *s;

	Tcl_DStringInit(&dString);
	TkBTreeLineTextAppend(textPtr,
			      textPtr->selIndex.linePtr,
			      textPtr->selIndex.charIndex,
			      textPtr->selIndex.charIndex + 1, 
			      (void*)&dString, 
			      textPtr->getFlags | TKT_GET_DSTRING,
			      NULL);
	s = Tcl_DStringValue(&dString) + textPtr->selRest;
	i = Tcl_DStringLength(&dString) - textPtr->selRest;
	if (i > maxBytes) {
	  textPtr->selRest += maxBytes;
	  i = maxBytes;
	} else {
	  textPtr->selRest = 0;
	  textPtr->selIndex.charIndex++;
	}
	maxBytes -= i;
	count += i;
	while (i--) {
	  *buffer++ = *s++;
	}
	textPtr->selRest = maxBytes;
	Tcl_DStringFree(&dString);
    }
    while (1) {
	/*
	 * Find the end of the current range of selected text.
	 */

	if (!TkBTreeNextTag(&search)) {
	    panic("TextFetchSelection couldn't find end of range");
	}

	/*
	 * Copy information from character lines into the buffer
	 * until either we run out of space in the buffer or we get
	 * to the end of this range of text.
	 */

	linePtr =  textPtr->selIndex.linePtr;
	startOff = textPtr->selIndex.charIndex;
	endOff = -1;
	while (1) {
	    int pos, m = maxBytes;

	    if (maxBytes == 0) {
		goto done;
	    }
	    if (linePtr == search.extIndex.linePtr) {
	      endOff = search.extIndex.charIndex;
	    }
	    pos = TkBTreeLineTextAppend(textPtr, linePtr, startOff, endOff,
					(void *)buffer, 
					textPtr->getFlags | TKT_GET_BUFFER,
					&maxBytes);
	    buffer += m - maxBytes;
	    count  += m - maxBytes;
	    /* Need to check the status: could reach the end of line,
	     * or the end of buffer (some place may been left in buffer
	     * if the representation of the last character takes more
	     * than 1 byte). */
	    if (pos == endOff) {	/* Done with this range */
	      break;
	    } else if (pos == TkBTreeCharsInLine(linePtr)) { /* End of line */
	      linePtr = TkBTreeNextLine(linePtr);
	      startOff = 0;
	      continue;
	    } else {		/* Did not reach the end of line */
	      if (maxBytes) {	/* Next index takes several bytes in
				 * string representation. */
		Tcl_DString dString;
		int i = maxBytes;
		char *s;

		Tcl_DStringInit(&dString);
		TkBTreeLineTextAppend(textPtr, linePtr, pos, pos + 1, 
				      (void*)&dString, 
				      textPtr->getFlags | TKT_GET_DSTRING,
				      NULL);
		s = Tcl_DStringValue(&dString);
		while (i--) {
		  *buffer++ = *s++;
		}
		textPtr->selRest = maxBytes;
		Tcl_DStringFree(&dString);
	      }
	      textPtr->selIndex.linePtr = linePtr;
	      textPtr->selIndex.charIndex = pos;
	      goto done;
	    }
	}

	/*
	 * Find the beginning of the next range of selected text.
	 */

	if (!TkBTreeNextTag(&search)) {
	    break;
	}
	textPtr->selIndex = search.extIndex;
    }

    done:
    *buffer = 0;
    return count;
}

/*
 *----------------------------------------------------------------------
 *
 * TkTextLostSelection --
 *
 *	This procedure is called back by Tk when the selection is
 *	grabbed away from a text widget.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	The "sel" tag is cleared from the window.
 *
 *----------------------------------------------------------------------
 */

void
TkTextLostSelection(clientData)
    ClientData clientData;		/* Information about text widget. */
{
    register TkText *textPtr = (TkText *) clientData;
    TkTextIndex start, end;

    if (!textPtr->exportSelection) {
	return;
    }

    /*
     * Just remove the "sel" tag from everything in the widget.
     */

    TkTextMakeIndex(textPtr->tree, 0, 0, &start);
    TkTextMakeIndex(textPtr->tree, TkBTreeNumLines(textPtr->tree), 0, &end);
    TkTextRedrawTag(textPtr, &start, &end, textPtr->selTagPtr, 1);
    TkBTreeTag(&start, &end, textPtr->selTagPtr, 0);
    textPtr->flags &= ~GOT_SELECTION;
}

/*
 *----------------------------------------------------------------------
 *
 * TextBlinkProc --
 *
 *	This procedure is called as a timer handler to blink the
 *	insertion cursor off and on.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	The cursor gets turned on or off, redisplay gets invoked,
 *	and this procedure reschedules itself.
 *
 *----------------------------------------------------------------------
 */

static void
TextBlinkProc(clientData)
    ClientData clientData;	/* Pointer to record describing text. */
{
    register TkText *textPtr = (TkText *) clientData;
    TkTextIndex index, index2;

    if (!(textPtr->flags & GOT_FOCUS) || (textPtr->insertOffTime == 0)) {
	return;
    }
    if (textPtr->flags & INSERT_ON) {
	textPtr->flags &= ~INSERT_ON;
	textPtr->insertBlinkHandler = Tcl_CreateTimerHandler(
		textPtr->insertOffTime, TextBlinkProc, (ClientData) textPtr);
    } else {
	textPtr->flags |= INSERT_ON;
	textPtr->insertBlinkHandler = Tcl_CreateTimerHandler(
		textPtr->insertOnTime, TextBlinkProc, (ClientData) textPtr);
    }
    TkTextMarkSegToIndex(textPtr, textPtr->insertMarkPtr, &index);
    TkTextIndexForwChars(&index, 1, &index2);
    TkTextChanged(textPtr, &index, &index2);
}

/*
 *----------------------------------------------------------------------
 *
 * TextSearchCmd --
 *
 *	This procedure is invoked to process the "search" widget command
 *	for text widgets.  See the user documentation for details on what
 *	it does.
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	See the user documentation.
 *
 *----------------------------------------------------------------------
 */

static int
TextSearchCmd(textPtr, interp, argc, argv)
    TkText *textPtr;		/* Information about text widget. */
    Tcl_Interp *interp;		/* Current interpreter. */
    int argc;			/* Number of arguments. */
    char **argv;		/* Argument strings. */
{
    int backwards, exact, c, i, argsLeft, noCase, leftToScan;
    size_t length;
    int numLines, startingLine, startingChar, lineNum, firstChar, lastChar;
    int code, matchLength, matchChar, passes, stopLine, searchWholeText;
    int patLength;
    char *arg, *pattern, *p, *startOfLine;
    Arg varName;
    char buffer[20];
    TkTextIndex index, stopIndex;
    Tcl_DString line;
#if 0
    Tcl_DString patDString;
#endif
    TkTextSegment *segPtr;
    TkTextLine *linePtr;
    Tcl_RegExp regExp = NULL;		/* Initialization needed only to
					 * prevent compiler warning. */

    /*
     * Parse switches and other arguments.
     */

    exact = 1;
    backwards = 0;
    noCase = 0;
    varName = NULL;
    for (i = 2; i < argc; i++) {
	arg = argv[i];
	if (arg[0] != '-') {
	    break;
	}
	length = strlen(arg);
	if (length < 2) {
	    badSwitch:
	    Tcl_AppendResult(interp, "bad switch \"", arg,
		    "\": must be -forward, -backward, -exact, -regexp, ",
		    "-nocase, -count, or --", (char *) NULL);
	    return TCL_ERROR;
	}
	c = arg[1];
	if ((c == 'b') && (strncmp(argv[i], "-backwards", length) == 0)) {
	    backwards = 1;
	} else if ((c == 'c') && (strncmp(argv[i], "-count", length) == 0)) {
	    if (i >= (argc-1)) {
		interp->result = "no value given for \"-count\" option";
		return TCL_ERROR;
	    }
	    i++;
	    varName = args[i];
	} else if ((c == 'e') && (strncmp(argv[i], "-exact", length) == 0)) {
	    exact = 1;
	} else if ((c == 'f') && (strncmp(argv[i], "-forwards", length) == 0)) {
	    backwards = 0;
	} else if ((c == 'n') && (strncmp(argv[i], "-nocase", length) == 0)) {
	    noCase = TKT_GET_NOCASE;
	} else if ((c == 'r') && (strncmp(argv[i], "-regexp", length) == 0)) {
	    exact = 0;
	} else if ((c == '-') && (strncmp(argv[i], "--", length) == 0)) {
	    i++;
	    break;
	} else {
	    goto badSwitch;
	}
    }
    argsLeft = argc - (i+2);
    if ((argsLeft != 0) && (argsLeft != 1)) {
	Tcl_AppendResult(interp, "wrong # args: should be \"",
		argv[0], " search ?switches? pattern index ?stopIndex?",
		(char *) NULL);
	return TCL_ERROR;
    }
    pattern = argv[i];

#if 0
    /*
     * Convert the pattern to lower-case if we're supposed to ignore case.
     */

    if (noCase) {
	Tcl_DStringInit(&patDString);
	Tcl_DStringAppend(&patDString, pattern, -1);
	pattern = Tcl_DStringValue(&patDString);
	for (p = pattern; *p != 0; p++) {
	    if (isupper(UCHAR(*p))) {
		*p = tolower(UCHAR(*p));
	    }
	}
    }
#endif

    if (TkTextGetIndex(interp, textPtr, argv[i+1], &index) != TCL_OK) {
	return TCL_ERROR;
    }
    numLines = TkBTreeNumLines(textPtr->tree);
    startingLine = TkBTreeLineIndex(index.linePtr);
    startingChar = index.charIndex;
    if (startingLine >= numLines) {
	if (backwards) {
	    startingLine = TkBTreeNumLines(textPtr->tree) - 1;
	    startingChar = TkBTreeCharsInLine(TkBTreeFindLine(textPtr->tree,
		    startingLine));
	} else {
	    startingLine = 0;
	    startingChar = 0;
	}
    }
    if (argsLeft == 1) {
	if (TkTextGetIndex(interp, textPtr, argv[i+2], &stopIndex) != TCL_OK) {
	    return TCL_ERROR;
	}
	stopLine = TkBTreeLineIndex(stopIndex.linePtr);
	if (!backwards && (stopLine == numLines)) {
	    stopLine = numLines-1;
	}
	searchWholeText = 0;
    } else {
	stopLine = 0;
	searchWholeText = 1;
    }

    /*
     * Scan through all of the lines of the text circularly, starting
     * at the given index.
     */

    matchLength = patLength = 0;	/* Only needed to prevent compiler
					 * warnings. */
    if (exact) {
	patLength = strlen(pattern);
    } else {
	regExp = Lang_RegExpCompile(interp, pattern, noCase);
	if (regExp == NULL) {
	    return TCL_ERROR;
	}
    }
    lineNum = startingLine;
    code = TCL_OK;
    Tcl_DStringInit(&line);
    for (passes = 0; passes < 2; ) {
	if (lineNum >= numLines) {
	    /*
	     * Don't search the dummy last line of the text.
	     */

	    goto nextLine;
	}

	/*
	 * Extract the text from the line.  If we're doing regular
	 * expression matching, drop the newline from the line, so
	 * that "$" can be used to match the end of the line.
	 */

	linePtr = TkBTreeFindLine(textPtr->tree, lineNum);

	/*
	 * The starting line is tricky: the first time we see it
	 * we check one part of the line, and the second pass through
	 * we check the other part of the line.  
	 */

	if (lineNum == startingLine) {
	    passes++;
	    TkBTreeLineTextAppend(textPtr, linePtr, 0, startingChar, (void*)&line, 
				  textPtr->getFlags | noCase | TKT_GET_DSTRING,
				  NULL);
	    firstChar = Tcl_DStringLength(&line);
	    TkBTreeLineTextAppend(textPtr, linePtr, startingChar, -1, (void*)&line, 
				  textPtr->getFlags | noCase | TKT_GET_DSTRING,
				  NULL);
	    if ((passes == 1) ^ backwards) {
		lastChar = INT_MAX;
	    } else {
	      lastChar = firstChar;
	      firstChar = 0;
	    }
	} else {
	    TkBTreeLineTextAppend(textPtr, linePtr, 0, -1, (void*)&line, 
				  textPtr->getFlags | noCase | TKT_GET_DSTRING,
				  NULL);
	    firstChar = 0;
	    lastChar = INT_MAX;
	}
	if (!exact) {
	    Tcl_DStringSetLength(&line, Tcl_DStringLength(&line)-1);
	}
	startOfLine = Tcl_DStringValue(&line);

	/*
	 * If we're ignoring case, convert the line to lower case.
	 */

#if 0
	if (noCase) {
	    for (p = Tcl_DStringValue(&line); *p != 0; p++) {
		if (isupper(UCHAR(*p))) {
		    *p = tolower(UCHAR(*p));
		}
	    }
	}
#endif

	/*
	 * Check for matches within the current line.  If so, and if we're
	 * searching backwards, repeat the search to find the last match
	 * in the line.
	 */

	matchChar = -1;
	do {
	    int thisLength;
	    if (exact) {
		p = strstr(startOfLine + firstChar, pattern);
		if (p == NULL) {
		    break;
		}
		i = p - startOfLine;
		thisLength = patLength;
	    } else {
		char *start, *end;
		int match;

		match = Lang_RegExpExec(interp, regExp,
			startOfLine + firstChar, startOfLine);
		if (match < 0) {
		    code = TCL_ERROR;
		    goto done;
		}
		if (!match) {
		    break;
		}
		Tcl_RegExpRange(regExp, 0, &start, &end);
		i = start - startOfLine;
		thisLength = end - start;
	    }
	    if (i >= lastChar) {
		break;
	    }
	    matchChar = i;
	    matchLength = thisLength;
	    firstChar = matchChar+1;
	} while (backwards);

	/*
	 * If we found a match then we're done.  Make sure that
	 * the match occurred before the stopping index, if one was
	 * specified.
	 */

	if (matchChar >= 0) {
	    /*
	     * The index information returned by the regular expression
	     * parser considers string representation. Now find the
	     * position in the text widget.
	     */

	    int offset = matchChar;
	    int posStart = TkBTreeLineTextAppend(textPtr, linePtr, 0, -1, NULL,
						 textPtr->getFlags | TKT_GET_OFFSET,
						 &offset);

	    offset += matchLength;
	    matchLength = TkBTreeLineTextAppend(textPtr, linePtr, posStart, -1, NULL,
						textPtr->getFlags | TKT_GET_OFFSET,
						&offset) 
	      - posStart;
	    if (offset) matchLength++; /* Include partially matched
					* character. */
	    TkTextMakeIndex(textPtr->tree, lineNum, posStart, &index);
	    if (!searchWholeText) {
		if (!backwards && (TkTextIndexCmp(&index, &stopIndex) >= 0)) {
		    goto done;
		}
		if (backwards && (TkTextIndexCmp(&index, &stopIndex) < 0)) {
		    goto done;
		}
	    }
	    if (varName != NULL) {
                Var variable;
                if (LangSaveVar(interp,varName,&variable,TK_CONFIG_ARRAYVAR) == TCL_OK) {
		    sprintf(buffer, "%d", matchLength);
		    if (Tcl_SetVar(interp, variable, buffer, TCL_LEAVE_ERR_MSG)
			    == NULL) {
		        code = TCL_ERROR;
                        LangFreeVar(variable);
		        goto done;
		    }
                    LangFreeVar(variable);
                } else {
		    code = TCL_ERROR;
		    goto done;
                }
	    }
	    TkTextPrintIndex(&index, buffer);
	    Tcl_SetResult(interp,buffer,TCL_VOLATILE);
	    goto done;
	}

	/*
	 * Go to the next (or previous) line;
	 */

	nextLine:
	if (backwards) {
	    lineNum--;
	    if (!searchWholeText) {
		if (lineNum < stopLine) {
		    break;
		}
	    } else if (lineNum < 0) {
		lineNum = numLines-1;
	    }
	} else {
	    lineNum++;
	    if (!searchWholeText) {
		if (lineNum > stopLine) {
		    break;
		}
	    } else if (lineNum >= numLines) {
		lineNum = 0;
	    }
	}
	Tcl_DStringSetLength(&line, 0);
    }
    done:
    Tcl_DStringFree(&line);
#if 0
    if (noCase) {
	Tcl_DStringFree(&patDString);
    }
#endif
    if (regExp) {
	Lang_FreeRegExp(regExp);
    }
    return code;
}

static Tk_ConfigSpec blockConfigSpecs[] = {
    {TK_CONFIG_CALLBACK, "-layoutcmd", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, layoutCmd),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_LANGARG, "-layoutwidths", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, widthsStr),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_INT, "-layoutdepth", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, depth),
		TK_CONFIG_DONT_SET_DEFAULT | TK_CONFIG_NULL_OK},
    {TK_CONFIG_BOOLEAN, "-empty", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, empty),
		TK_CONFIG_DONT_SET_DEFAULT | TK_CONFIG_NULL_OK},
    {TK_CONFIG_CALLBACK, "-deletecallback", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, deleteCallBack),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_CALLBACK, "-leafdeletecallback", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, leafDeleteCallBack),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_CALLBACK, "-leafaddcallback", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, leafAddCallBack),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_CALLBACK, "-leafemptycallback", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextBlock, leafEmptyCallBack),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_END, (char *) NULL, (char *) NULL, (char *) NULL,
	(char *) NULL, 0, 0}
};
static Tk_ConfigSpec blockInstanceConfigSpecs[] = {
    {TK_CONFIG_LANGARG, "-instancedata", (char *) NULL, (char *) NULL,
	(char *) NULL, Tk_Offset(TkTextITree, data),
		TK_CONFIG_NULL_OK},
    {TK_CONFIG_END, (char *) NULL, (char *) NULL, (char *) NULL,
	(char *) NULL, 0, 0}
};


/*
 *--------------------------------------------------------------
 *
 * TkTextBlockCmd --
 *
 *	This procedure is invoked to process the "block" options of
 *	the widget command for text widgets. See the user documentation
 *	for details on what it does.
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	See the user documentation.
 *
 *--------------------------------------------------------------
 */

int
TkTextBlockCmd(textPtr, interp, argc, argv)
    register TkText *textPtr;	/* Information about text widget. */
    Tcl_Interp *interp;		/* Current interpreter. */
    int argc;			/* Number of arguments. */
    char **argv;		/* Argument strings.  Someone else has already
				 * parsed this command enough to know that
				 * argv[1] is "mark". */
{
    TkTextIndex index1, index2;
    int result = TCL_OK;
    int length, i;
    char c;
    TkTextBlock *blockPtr;
    Tcl_HashEntry *hPtr;
    Tcl_HashSearch search;
    int new;


    if (argc < 3) {
        Tcl_AppendResult(interp, "wrong # args: should be \"",
			 argv[0], " block option ?arg arg ...?\"",
			 (char *) NULL);
	return TCL_ERROR;
    }
    c = argv[2][0];
    length = strlen(argv[2]);
    if ((c == 'c') && (strncmp(argv[2], "cget", length) == 0)
	    && (length >= 2)) {
	if (argc != 5) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block cget blockName option\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
	hPtr = Tcl_FindHashEntry(&textPtr->blockTable, LangString(args[3]));
	if (hPtr == NULL) {
	    Tcl_AppendResult(interp, "there is no block named \"",
		    argv[3], "\"", (char *) NULL);
	    return TCL_ERROR;
	}
	blockPtr = (TkTextBlock *) Tcl_GetHashValue(hPtr);
	return Tk_ConfigureValue(interp, textPtr->tkwin, blockConfigSpecs,
		(char *) blockPtr, argv[4], 0);
    } else if ((c == 'c') && (strncmp(argv[2], "configure", length) == 0)
	    && (length >= 2)) {
        if (argc < 4) {
	  Tcl_AppendResult(interp, "wrong # args: should be \"",
			   argv[0], " block configure blockName ?arg arg ...?\"",
			   (char *) NULL);
	  return TCL_ERROR;
	}
	hPtr = Tcl_CreateHashEntry(&textPtr->blockTable, 
				   LangString(args[3]), &new);
	if (new) {
	  blockPtr = (TkTextBlock *) ckalloc(sizeof(TkTextBlock));
	  Tcl_SetHashValue(hPtr, blockPtr);
	  blockPtr->name = Tcl_GetHashKey(&textPtr->blockTable, hPtr);
	  blockPtr->layoutCmd = NULL;
	  blockPtr->deleteCallBack = NULL;
	  blockPtr->leafDeleteCallBack = NULL;
	  blockPtr->leafAddCallBack = NULL;
	  blockPtr->leafEmptyCallBack = NULL;
	  blockPtr->count = 0;
	  blockPtr->depth = 0;
	  blockPtr->empty = 0;
	  blockPtr->widthsNum = 0;
	  blockPtr->widthsMin = NULL;
	  blockPtr->widthsMax = NULL;
	  blockPtr->widthsStr = NULL;
	} else {
	  blockPtr = (TkTextBlock *) Tcl_GetHashValue(hPtr);
	}
	if (argc == 4) {
	    return Tk_ConfigureInfo(interp, textPtr->tkwin, blockConfigSpecs,
		    (char *) blockPtr, (char *) NULL, 0);
	} else if (argc == 5) {
	    return Tk_ConfigureInfo(interp, textPtr->tkwin, blockConfigSpecs,
		    (char *) blockPtr, argv[4], 0);
	} else {
	    int result;
	    char *w = argv[0];

	    result = Tk_ConfigureWidget(interp, textPtr->tkwin, blockConfigSpecs,
		    argc-4, argv+4, (char *) blockPtr, 0);
	    blockPtr->widthsNum = 0;
	    if (blockPtr->widthsStr) {
              int argc, code, count;
              char *string;
	      Arg *args;
	      LangFreeProc *freeProc = NULL;
	      
	      if (blockPtr->widthsMin) {
		ckfree((char*)blockPtr->widthsMin);
	      }
	      if (blockPtr->widthsMax) {
		ckfree((char*)blockPtr->widthsMax);
	      }
              code = Lang_SplitList(interp, blockPtr->widthsStr, 
				    &argc, &args, &freeProc);
	      if (code == TCL_ERROR) {
		blockPtr->widthsNum = 0;
		Tcl_AppendResult(interp, " \"", blockPtr->widthsStr, 
				 "\" in \"", w, " block configure\" command",
				 (char *) NULL);
		return TCL_ERROR;
	      }
	      blockPtr->widthsMin = (int*) ckalloc(argc*sizeof(int));
	      blockPtr->widthsMax = (int*) ckalloc(argc*sizeof(int));
	      for (count = 0; count < argc; count++) {
		int min, max;

		if (LangIsList(args[count])) {
		  int argc1;
		  Arg *args1;
		  LangFreeProc *freeProc1 = NULL;

		  code = Lang_SplitList(interp, args[count],
					&argc1, &args1, &freeProc1);
		  if ((code != TCL_OK) || (argc1 != 2)) {
		    Tcl_AppendResult(interp, "wrong format of ",
				     "\"-layoutwidths\" element \"",
				     LangString(args[count]),
				     "\": expect a list of length 2",
				     (char *) NULL);
		    if (args1 != NULL && freeProc) (*freeProc1)(argc1,args1);
		    if (args != NULL && freeProc) (*freeProc)(argc,args);
		    return TCL_ERROR;
		  }
		  min = LangInt(args1[0]);
		  max = LangInt(args1[1]);
		  if (args1 != NULL && freeProc) (*freeProc1)(argc1,args1);
		} else {
		  max = min = LangInt(args[count]);
		}
		blockPtr->widthsMin[count] = min;
		blockPtr->widthsMax[count] = max;
	      }
	      blockPtr->widthsNum = argc;
	      if (args != NULL && freeProc) (*freeProc)(argc,args);
 	    }
	    TkTextRelayoutWindow(textPtr);
	    return result;
	}
    } else if ((c == 'd') && (strncmp(argv[2], "data", length) == 0)
	    && (length >= 2)) {
        Arg arga[2];
	int result;
	TkTextSegment *segPtr;

	arga[0] = NULL;
	arga[1] = NULL;
        if ((argc < 4) || (argc > 5)) {
	  Tcl_AppendResult(interp, "wrong # args: should be \"",
			   argv[0], " block data index ?data?\"",
			   (char *) NULL);
	  return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	    return TCL_ERROR;
	}
	segPtr = TkIBTreeAt(&index1, 1);
	if (!segPtr) {
	  Tcl_AppendResult(interp, "block data issued not inside a block.",
			   (char *) NULL);
	  return TCL_ERROR;
	}
	LangSetString(&(arga[0]), "-instancedata");
	if (argc == 4) {
	    result = Tk_ConfigureValue(interp, textPtr->tkwin, 
				       blockInstanceConfigSpecs,
				       (char *) &segPtr->body.itree,
				       LangString(arga[0]), 0);
	} else {
	    arga[1] = args[4];		/* Should work with TCL and Perl. */
	    result = Tk_ConfigureWidget(interp, textPtr->tkwin, 
					blockInstanceConfigSpecs, 2, arga, 
					(char *) &segPtr->body.itree, 0);
	    TkTextRelayoutWindow(textPtr);
	}
	LangFreeArg(arga[0], LANG_DYNAMIC);
	return result;
    } else if ((c == 't') && (strncmp(argv[2], "trim", length) == 0)) {
        TkTextSegment *segPtr;

	if (argc != 4) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block trim index\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	    return TCL_ERROR;
	}
	segPtr = TkIBTreeAt(&index1, 1);
	if (segPtr) {
	    return TkIBTreeTrim(textPtr, segPtr);
	} else {
	    Tcl_AppendResult(interp, "Cannot trim outside of block",
			     (char *) NULL);
	    return TCL_ERROR;
	}
    } else if ((c == 'a') && (strncmp(argv[2], "at", length) == 0)
	       && (length >= 2)) {
        TkTextSegment *segPtr;

	if (argc != 4) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block at index\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	    return TCL_ERROR;
	}
	segPtr = TkIBTreeAt(&index1, 0);
	if (segPtr) {
	  ListFactory listFactory;

	  ListFactoryInit(&listFactory);
	  TkIBTreeInfo(segPtr, &listFactory);
	  ListFactoryResult(textPtr->interp, &listFactory);
	  ListFactoryFree(&listFactory);
	}
    } else if ((c == 'a') && (strncmp(argv[2], "addline", length) == 0)
	       && (length >= 2)) {
        struct DLine **dlPtrs;

	if (argc != 4) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block addline index\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	    return TCL_ERROR;
	}
	dlPtrs = ckalloc(sizeof(struct DLine*) * (textPtr->numDLines + 1));
	i = 0;
	if (textPtr->dlinePtrs) {
	  for (i = 0; i < textPtr->numDLines; i++) {
	    dlPtrs[i] = textPtr->dlinePtrs[i];
	  }
	  ckfree((char*)textPtr->dlinePtrs);
	} 
	textPtr->dlinePtrs = dlPtrs;
	textPtr->dlinePtrs[textPtr->numDLines++] 
	  = TkTextGetDLine(textPtr, &index1);
	Tcl_IntResults(interp, 1, 0, textPtr->numDLines);
	TkTextRelayoutWindow(textPtr);
    } else if ((c == 'o') && (strncmp(argv[2], "of", length) == 0)) {
        TkTextSegment *segPtr;

	if (argc != 4) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block of index\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	    return TCL_ERROR;
	}
	segPtr = TkIBTreeAt(&index1, 1);
	if (segPtr) {
	  ListFactory listFactory;

	  ListFactoryInit(&listFactory);
	  TkIBTreeInfo(segPtr, &listFactory);
	  ListFactoryResult(textPtr->interp, &listFactory);
	  ListFactoryFree(&listFactory);
	}
    } else if ((c == 'd') && (strncmp(argv[2], "delete", length) == 0)
	       && (length == 6)) {
        int result = TCL_OK;

	for (i = 3; i < argc; i++) {
	    hPtr = Tcl_FindHashEntry(&textPtr->blockTable, argv[i]);
	    if (hPtr != NULL) {
		blockPtr = (TkTextBlock *) Tcl_GetHashValue(hPtr);
		if (blockPtr->count) {
		  Tcl_AppendResult(interp, "Cannot delete block \"", argv[i], 
				   "\" that is in use",
				   (char *) NULL);
		  result = TCL_ERROR;
		  continue;
		}
		Tcl_DeleteHashEntry(hPtr);
		DeleteBlock(textPtr, blockPtr);
	    } else {
		  Tcl_AppendResult(interp, "Unknown block \"", argv[i], 
				   "\"",
				   (char *) NULL);
		  result = TCL_ERROR;
	    }
	}
	return result;
    } else if ((c == 'd') && (strncmp(argv[2], "deletelines", length) == 0)
	       && (length > 6)) {
	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block deletelines\"",
		    (char *) NULL);
	    return TCL_ERROR;
	}
        if (textPtr->dlinePtrs) {
	  int i;

	  for (i = 0; i < textPtr->numDLines; i++) {
	    TkTextFreeDLine(textPtr, textPtr->dlinePtrs[i]);
	  }
	  ckfree((char*)textPtr->dlinePtrs);
	  textPtr->numDLines = 0;
	  textPtr->dlinePtrs = NULL;
	  TkTextRelayoutWindow(textPtr);
	}
    } else if ((c == 'i') && (strncmp(argv[2], "insert", length) ==
			      0)) {
        int lineIndex, numLines;

	if ((argc < 5) || (argc > 6)) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block insert blockName position ?position?",
		    (char *) NULL);
	    return TCL_ERROR;
	}
        if ((TkTextGetIndex(interp, textPtr, argv[4], &index1) != TCL_OK)
	    || (argc >= 6 
		&& TkTextGetIndex(interp, textPtr, argv[5], &index2)
		!= TCL_OK)) {
	  return TCL_ERROR;
	}
	lineIndex = TkBTreeLineIndex(index1.linePtr);
	if (lineIndex == (numLines = TkBTreeNumLines(textPtr->tree))) {
	    lineIndex--;
	    TkTextMakeIndex(textPtr->tree, lineIndex, 1000000, &index1);
	}
	if (argc < 6) {
	    index2 = index1;
	} else {
	        lineIndex = TkBTreeLineIndex(index2.linePtr);
		if (lineIndex == numLines) {
		    lineIndex--;
		    TkTextMakeIndex(textPtr->tree, lineIndex, 1000000, &index2);
		}
	}

	hPtr = Tcl_FindHashEntry(&textPtr->blockTable, argv[3]);
	if (hPtr == NULL) {
	    Tcl_AppendResult(interp, "there is no block named \"",
		    argv[3], "\"", (char *) NULL);
	    return TCL_ERROR;
	}
	blockPtr = (TkTextBlock *) Tcl_GetHashValue(hPtr);
	if (blockPtr->empty && ((index1.linePtr != index2.linePtr) 
				|| (index1.charIndex != index2.charIndex))) {
	    Tcl_AppendResult(interp, "Attempt to create empty block \"",
		    argv[3], "\" with contents", (char *) NULL);
	    return TCL_ERROR;
	}
	TkTextChanged(textPtr, &index1, &index2);

	/*
	 *  Invalidate any selection retrievals in progress.
	 */

	textPtr->selOffset = -1;

	return TkBTreeMakeBlock(textPtr, &index1, &index2, blockPtr);
    } else if ((c == 'n') && (strncmp(argv[2], "names", length) == 0)) {
	if (argc != 3) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block names\"", (char *) NULL);
	    return TCL_ERROR;
	}
	for (hPtr = Tcl_FirstHashEntry(&textPtr->blockTable, &search);
		hPtr != NULL; hPtr = Tcl_NextHashEntry(&search)) {
	    Tcl_AppendElement(interp,
		    Tcl_GetHashKey(&textPtr->blockTable, hPtr));
	}
    } else if ((c == 'l') && (strncmp(argv[2], "list", length) == 0)) {
        ListFactory listFactory;
	TkTextLine *linePtr;
	int offset, dummy;
	Arg arg = NULL;

	if (argc != 5) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block list index1 index2\"", (char *) NULL);
	    return TCL_ERROR;
	}
	if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK
	    || TkTextGetIndex(interp, textPtr, argv[4], &index2) != TCL_OK) {
	    return TCL_ERROR;
	}
	if (TkTextIndexCmp(&index1, &index2) >= 0) {
	    return TCL_OK;
	}
	linePtr = index1.linePtr;
	offset = index1.charIndex; 
	ListFactoryInit(&listFactory);
	LangSetString(&arg, "");
	while (linePtr != index2.linePtr) {
	  TkBTreeLineTextAppend(textPtr, linePtr, offset, -1, 
				(void*)&listFactory, 
				textPtr->getFlags | TKT_GET_LIST, NULL);
	  offset = -1;			/* Report all of the rest */
	  ListFactoryAppendCopyWithType(&listFactory, arg, 
					IdType("NL",
					       "Tk::Text::NewLine"));
	  linePtr = TkBTreeNextLine(linePtr);
	}
	TkBTreeLineTextAppend(textPtr, linePtr, offset, index2.charIndex,
			      (void*)&listFactory, 
			      textPtr->getFlags | TKT_GET_LIST, NULL);
	ListFactoryResult(textPtr->interp, &listFactory);
	ListFactoryFree(&listFactory);
    } else if ((c == 'r') && (strncmp(argv[2], "rename", length) == 0)) {
	TkTextSegment *segPtr;

	if (argc != 5) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block rename index newtype\"", (char *) NULL);
	    return TCL_ERROR;
	}
        if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	  return TCL_ERROR;
	}
	segPtr = TkIBTreeAt(&index1,1);

	if (!segPtr) {
	    Tcl_AppendResult(interp, "no block at \"",
			     argv[3], "\"", (char *) NULL);
	    return TCL_ERROR;
	}
	hPtr = Tcl_FindHashEntry(&textPtr->blockTable, argv[4]);
	if (hPtr == NULL) {
	    Tcl_AppendResult(interp, "there is no block named \"",
		    argv[4], "\"", (char *) NULL);
	    return TCL_ERROR;
	}
	blockPtr = (TkTextBlock *) Tcl_GetHashValue(hPtr);

	segPtr->body.itree.blockPtr->count--;
	blockPtr->count++;
	segPtr->body.itree.blockPtr = blockPtr;
    } else if ((c == 's') && (strncmp(argv[2], "split", length) == 0)) {
        int level = 0;
	char *end;

	if (argc != 4 && argc != 5) {
	    Tcl_AppendResult(interp, "wrong # args: should be \"",
		    argv[0], " block split index ?level?\"", (char *) NULL);
	    return TCL_ERROR;
	}
        if (TkTextGetIndex(interp, textPtr, argv[3], &index1) != TCL_OK) {
	  return TCL_ERROR;
	}
	if (argc == 5) {
	  level = LangInt(args[4]);
	}
	level = TkIBTreeSplit(&index1, level);
	Tcl_IntResults(interp, 1, 0, level);
    } else {
	Tcl_AppendResult(interp, "bad block option \"", argv[2],
		"\":  must be at, addline, cget, configure, delete, ",
		"deletelines, insert, list, names, of, rename, split or trim",
		(char *) NULL);
	return TCL_ERROR;
    }
    return TCL_OK;
}

/*
 *--------------------------------------------------------------
 *
 * DeleteBlock --
 *
 *	Deletes the given block type. No error checking is done.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *	Memory is freed.
 *
 *--------------------------------------------------------------
 */

static void
DeleteBlock(textPtr, blockPtr)
    TkText *textPtr;			/* Text widget that contains
					 * the block. */
    TkTextBlock *blockPtr;		/* Block to delete. */
{
  if (blockPtr->widthsMin) {
    ckfree((char*)blockPtr->widthsMin);
  }
  if (blockPtr->widthsMax) {
    ckfree((char*)blockPtr->widthsMax);
  }
  ckfree((char*)blockPtr);
}

/*
 *----------------------------------------------------------------------
 *
 * TkTextGetTabs --
 *
 *	Parses a string description of a set of tab stops.
 *
 * Results:
 *	The return value is a pointer to a malloc'ed structure holding
 *	parsed information about the tab stops.  If an error occurred
 *	then the return value is NULL and an error message is left in
 *	interp->result.
 *
 * Side effects:
 *	Memory is allocated for the structure that is returned.  It is
 *	up to the caller to free this structure when it is no longer
 *	needed.
 *
 *----------------------------------------------------------------------
 */

TkTextTabArray *
TkTextGetTabs(interp, tkwin, arg)
    Tcl_Interp *interp;			/* Used for error reporting. */
    Tk_Window tkwin;			/* Window in which the tabs will be
					 * used. */
    Arg arg;				/* Description of the tab stops.  See
					 * the text manual entry for details. */
{
    int argc, i, count, c;
    char **argv;
    TkTextTabArray *tabArrayPtr;
    TkTextTab *tabPtr;
     LangFreeProc *freeProc = NULL;

    if (Lang_SplitList(interp, arg, &argc, &argv, &freeProc) != TCL_OK) {
	return NULL;
    }

    /*
     * First find out how many entries we need to allocate in the
     * tab array.
     */

    count = 0;
    for (i = 0; i < argc; i++) {
	c = argv[i][0];
	if ((c != 'l') && (c != 'r') && (c != 'c') && (c != 'n')) {
	    count++;
	}
    }

    /*
     * Parse the elements of the list one at a time to fill in the
     * array.
     */

    tabArrayPtr = (TkTextTabArray *) ckalloc((unsigned)
	    (sizeof(TkTextTabArray) + (count-1)*sizeof(TkTextTab)));
    tabArrayPtr->numTabs = 0;
    for (i = 0, tabPtr = &tabArrayPtr->tabs[0]; i  < argc; i++, tabPtr++) {
	if (Tk_GetPixels(interp, tkwin, argv[i], &tabPtr->location)
		!= TCL_OK) {
	    goto error;
	}
	tabArrayPtr->numTabs++;

	/*
	 * See if there is an explicit alignment in the next list
	 * element.  Otherwise just use "left".
	 */

	tabPtr->alignment = LEFT;
	if ((i+1) == argc) {
	    continue;
	}
	c = UCHAR(argv[i+1][0]);
	if (!isalpha(c)) {
	    continue;
	}
	i += 1;
	if ((c == 'l') && (strncmp(argv[i], "left",
		strlen(argv[i])) == 0)) {
	    tabPtr->alignment = LEFT;
	} else if ((c == 'r') && (strncmp(argv[i], "right",
		strlen(argv[i])) == 0)) {
	    tabPtr->alignment = RIGHT;
	} else if ((c == 'c') && (strncmp(argv[i], "center",
		strlen(argv[i])) == 0)) {
	    tabPtr->alignment = CENTER;
	} else if ((c == 'n') && (strncmp(argv[i],
		"numeric", strlen(argv[i])) == 0)) {
	    tabPtr->alignment = NUMERIC;
	} else {
	    Tcl_AppendResult(interp, "bad tab alignment \"",
		    argv[i], "\": must be left, right, center, or numeric",
		    (char *) NULL);
	    goto error;
	}
    }
    if (freeProc)
      (*freeProc)(argc,argv);
    return tabArrayPtr;

    error:
    ckfree((char *) tabArrayPtr);
    ckfree((char *) argv);
    return NULL;
}

/*
 *----------------------------------------------------------------------
 *
 * TextDumpCmd --
 *
 *	Return information about the text, tags, marks, and embedded windows
 *	in a text widget.  See the man page for the description of the
 *	text dump operation for all the details.
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	Memory is allocated for the result, if needed (standard Tcl result
 *	side effects).
 *
 *----------------------------------------------------------------------
 */

static int
TextDumpCmd(textPtr, interp, argc, argv)
    register TkText *textPtr;	/* Information about text widget. */
    Tcl_Interp *interp;		/* Current interpreter. */
    int argc;			/* Number of arguments. */
    char **argv;		/* Argument strings.  Someone else has already
				 * parsed this command enough to know that
				 * argv[1] is "dump". */
{
    TkTextIndex index1, index2;
    int arg;
    int lineno;			/* Current line number */
    int what = 0;		/* bitfield to select segment types */
    int atEnd;			/* True if dumping up to logical end */
    TkTextLine *linePtr;
    LangCallback *command = NULL;	/* Script callback to apply to segments */
#define TK_DUMP_TEXT	0x1
#define TK_DUMP_MARK	0x2
#define TK_DUMP_TAG	0x4
#define TK_DUMP_WIN	0x8
#define TK_DUMP_ALL	(TK_DUMP_TEXT|TK_DUMP_MARK|TK_DUMP_TAG|TK_DUMP_WIN)

    for (arg=2 ; argv[arg] != (char *) NULL ; arg++) {
	size_t len;
	if (argv[arg][0] != '-') {
	    break;
	}
	len = strlen(argv[arg]);
	if (strncmp("-all", argv[arg], len) == 0) {
	    what = TK_DUMP_ALL;
	} else if (strncmp("-text", argv[arg], len) == 0) {
	    what |= TK_DUMP_TEXT;
	} else if (strncmp("-tag", argv[arg], len) == 0) {
	    what |= TK_DUMP_TAG;
	} else if (strncmp("-mark", argv[arg], len) == 0) {
	    what |= TK_DUMP_MARK;
	} else if (strncmp("-window", argv[arg], len) == 0) {
	    what |= TK_DUMP_WIN;
	} else if (strncmp("-command", argv[arg], len) == 0) {
	    arg++;
	    if (arg >= argc || command != (LangCallback *) NULL) {
		Tcl_AppendResult(interp, "Usage: ", argv[0], " dump ?-all -text -mark -tag -window? ?-command script? index ?index2?", NULL);
		return TCL_ERROR;
	    }
	    command = LangMakeCallback(args[arg]);
	} else {
	    Tcl_AppendResult(interp, "Usage: ", argv[0], " dump ?-all -text -mark -tag -window? ?-command script? index ?index2?", NULL);
	    goto error;
	}
    }
    if (arg >= argc) {
	Tcl_AppendResult(interp, "Usage: ", argv[0], " dump ?-all -text -mark -tag -window? ?-command script? index ?index2?", NULL);
	goto error;
    }
    if (what == 0) {
	what = TK_DUMP_ALL;
    }
    if (TkTextGetIndex(interp, textPtr, argv[arg], &index1) != TCL_OK) {
	goto error;
    }
    lineno = TkBTreeLineIndex(index1.linePtr) + 1;
    arg++;
    atEnd = 0;
    if (argc == arg) {
	TkTextIndexForwChars(&index1, 1, &index2);
    } else {
	if (TkTextGetIndex(interp, textPtr, argv[arg], &index2) != TCL_OK) {
	    goto error;
	}
	if (strncmp(argv[arg], "end", strlen(argv[arg])) == 0) {
	    atEnd = 1;
	}
    }
    if (TkTextIndexCmp(&index1, &index2) >= 0) {
	goto ok;
    }
    if (index1.linePtr == index2.linePtr) {
	DumpLine(interp, textPtr, what, index1.linePtr,
	    index1.charIndex, index2.charIndex, lineno, command);
    } else {
	DumpLine(interp, textPtr, what, index1.linePtr,
		index1.charIndex, 32000000, lineno, command);
	linePtr = index1.linePtr;
	while ((linePtr = TkBTreeNextLine(linePtr)) != (TkTextLine *)NULL) {
	    lineno++;
	    if (linePtr == index2.linePtr) {
		break;
	    }
	    DumpLine(interp, textPtr, what, linePtr, 0, 32000000,
		    lineno, command);
	}
	DumpLine(interp, textPtr, what, index2.linePtr, 0,
		index2.charIndex, lineno, command);
    }
    /*
     * Special case to get the leftovers hiding at the end mark.
     */
    if (atEnd) {
	DumpLine(interp, textPtr, what & ~TK_DUMP_TEXT, index2.linePtr,
		0, 1, lineno, command);
    }
ok:
    if (command != (LangCallback *) NULL)
	LangFreeCallback(command);
    return TCL_OK;
error:
    if (command != (LangCallback *) NULL)
	LangFreeCallback(command);
    return TCL_ERROR;
}

/*
 * DumpLine
 * 	Return information about a given text line from character
 *	position "start" up to, but not including, "end".
 *
 * Results:
 *	A standard Tcl result.
 *
 * Side effects:
 *	None, but see DumpSegment.
 */
static void
DumpLine(interp, textPtr, what, linePtr, start, end, lineno, command)
    Tcl_Interp *interp;
    TkText *textPtr;
    int what;			/* bit flags to select segment types */
    TkTextLine *linePtr;	/* The current line */
    int start, end;		/* Character range to dump */
    int lineno;			/* Line number for indices dump */
    LangCallback *command;	/* Script to apply to the segment */
{
    int offset;
    TkTextSegment *segPtr;
    /*
     * Must loop through line looking at its segments.
     * character
     * toggleOn, toggleOff
     * mark
     * window
     */
    for (offset = 0, segPtr = linePtr->segPtr ;
	    (offset < end) && (segPtr != (TkTextSegment *)NULL) ;
	    offset += segPtr->size, segPtr = segPtr->nextPtr) {
	int result = TCL_OK;
	if ((what & TK_DUMP_TEXT) && (segPtr->typePtr == &tkTextCharType) &&
		(offset + segPtr->size > start)) {
	    char savedChar;			/* Last char used in the seg */
	    int last = segPtr->size;		/* Index of savedChar */
	    int first = 0;			/* Index of first char in seg */
	    if (offset + segPtr->size > end) {
		last = end - offset;
	    }
	    if (start > offset) {
		first = start - offset;
	    }
	    savedChar = segPtr->body.chars[last];
	    segPtr->body.chars[last] = '\0';
	    result = DumpSegment(interp, "text", segPtr->body.chars + first,
		    command, lineno, offset + first, what);
	    segPtr->body.chars[last] = savedChar;
	} else if ((offset >= start)) {
	    if ((what & TK_DUMP_MARK) && (segPtr->typePtr->name[0] == 'm')) {
		TkTextMark *markPtr = (TkTextMark *)&segPtr->body;
		char *name = Tcl_GetHashKey(&textPtr->markTable, markPtr->hPtr);
		result = DumpSegment(interp, "mark", name,
			command, lineno, offset, what);
	    } else if ((what & TK_DUMP_TAG) &&
			(segPtr->typePtr == &tkTextToggleOnType)) {
		result = DumpSegment(interp, "tagon",
			segPtr->body.toggle.tagPtr->name,
			command, lineno, offset, what);
	    } else if ((what & TK_DUMP_TAG) && 
			(segPtr->typePtr == &tkTextToggleOffType)) {
		result = DumpSegment(interp, "tagoff",
			segPtr->body.toggle.tagPtr->name,
			command, lineno, offset, what);
	    } else if ((what & TK_DUMP_WIN) && 
			(segPtr->typePtr->name[0] == 'w')) {
		TkTextEmbWindow *ewPtr = (TkTextEmbWindow *)&segPtr->body;
		char *pathname;
		if (ewPtr->tkwin == (Tk_Window) NULL) {
		    pathname = "";
		} else {
		    pathname = Tk_PathName(ewPtr->tkwin);
		}
		result = DumpSegment(interp, "window", pathname,
			command, lineno, offset, what);
	    }
	}
    }
}

/*
 * DumpSegment
 *	Either append information about the current segment to the result,
 *	or make a script callback with that information as arguments.
 *
 * Results:
 *	None
 *
 * Side effects:
 *	Either evals the callback or appends elements to the result string.
 */
static int
DumpSegment(interp, key, value, command, lineno, offset, what)
    Tcl_Interp *interp;
    char *key;			/* Segment type key */
    char *value;		/* Segment value */
    LangCallback *command;	/* Script callback */
    int lineno;			/* Line number for indices dump */
    int offset;			/* Character position */
    int what;			/* Look for TK_DUMP_INDEX bit */
{
    char buffer[30];
    sprintf(buffer, "%d.%d", lineno, offset);
    if (command == (LangCallback *) NULL) {
	Tcl_AppendElement(interp, key);
	Tcl_AppendElement(interp, value);
	Tcl_AppendElement(interp, buffer);
	return TCL_OK;
    } else {
	int result;
#if 0
        /* Tcl/Tk passes list of three strings */
	char *argv[4];
	char *list;
	argv[0] = key;
	argv[1] = value;
	argv[2] = buffer;
	argv[3] = (char *) NULL;
	list = Tcl_Merge(3, argv);
	result = Tcl_VarEval(interp, command, " ", list, (char *) NULL);
	ckfree(list);
#else
	result = LangDoCallback(interp, command, 1, 3, "%s %s %s", key, value, buffer);    
#endif
	return result;
    }
}

