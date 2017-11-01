.pragma library

function image(url) {
    if (!url) return "";
    return "qrc:/images/" + url;
}

function screen(url) {
    if (!url) return "";
    return "qrc:/qml/screens/" + url;
}

function animation(url) {
    if (!url) return "";
    return "qrc:/animations/" + url;
}
