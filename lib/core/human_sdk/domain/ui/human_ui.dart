import 'dart:html' as html;

class HumanUI {
  static const String modelDentalID = 'DentalModel';
  static const String modelHeartID = 'HeartModel';

  static void setToken(String apiKey) {
    final meta = html.MetaElement()
      ..content = apiKey
      ..name = 'secutiry-token-visor';
    html.document.head?.append(meta);
  }

  static html.DivElement createView(String id) {
    final divContent = html.DivElement();
    divContent.id = 'human$id';
    divContent.style.height = '100%';
    divContent.style.width = '100%';

    final iframe = html.IFrameElement()
      ..src = ''
      ..id = id
      ..style.border = 'none'
      ..style.background = 'black'
      ..style.margin = '0px'
      ..style.padding = '0px'
      ..style.width = '100%'
      ..style.height = '100%';
    final div1 = _div();
    div1.style.top = '0px';

    final div2 = _div();
    div2.style.bottom = '0px';

    divContent
      ..append(iframe)
      ..append(div1)
      ..append(div2);

    return divContent;
  }

  static void setURL(String id, String url) {
    final el = html.document.getElementById(id);
    if (el is html.IFrameElement) {
      el.src = url;
    }
  }

  static html.DivElement _div() {
    final div = html.DivElement();
    div.style.height = '55px';
    div.style.width = '100%';
    div.style.position = 'absolute';
    div.style.zIndex = '1';
    div.style.background = 'black';
    return div;
  }
}
