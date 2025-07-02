stock createServerTextDraws() {
  sTDblackBackground = TextDrawCreate(0.0, 0.0, "LD_SPAC:white");
  TextDrawTextSize(sTDblackBackground, 640.0000, 450.0000);
  TextDrawAlignment(sTDblackBackground, TEXT_DRAW_ALIGN_LEFT);
  TextDrawColour(sTDblackBackground, 255);
  TextDrawBackgroundColour(sTDblackBackground, 255);
  TextDrawFont(sTDblackBackground, TEXT_DRAW_FONT_SPRITE_DRAW);
  TextDrawSetProportional(sTDblackBackground, bool:0);
  TextDrawSetShadow(sTDblackBackground, 0);
}

stock destroyServerTextDraws() {
  TextDrawDestroy(sTDblackBackground);
}