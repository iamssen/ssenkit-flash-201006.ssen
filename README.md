```
.
├── asset
│   ├── chess.png
│   └── profile.png
├── name
│   └── ssen
│       ├── Index.as
│       └── SiteInitializer.as
├── ssen
│   ├── core
│   │   ├── DateX.as
│   │   ├── DisplayX.as
│   │   ├── MathX.as
│   │   ├── Random.as
│   │   ├── TextX.as
│   │   ├── VectorSortCompareFunctions.as
│   │   ├── draw
│   │   │   ├── DistortBitmap.as
│   │   │   ├── Donut.as
│   │   │   ├── DrawTest.as
│   │   │   ├── IDrawData.as
│   │   │   ├── Line.as
│   │   │   ├── PathMaker.as
│   │   │   ├── Rect.as
│   │   │   ├── drawDatas.as
│   │   │   └── material
│   │   │       ├── BitmapMaterial.as
│   │   │       ├── FrameMaterial.as
│   │   │       ├── IDrawMaterial.as
│   │   │       ├── IDrawMaterialSet.as
│   │   │       ├── ITextFormatSet.as
│   │   │       ├── RoundRectMaterial.as
│   │   │       └── SolidMaterial.as
│   │   ├── geom
│   │   │   ├── GeomX.as
│   │   │   └── Padding.as
│   │   ├── net
│   │   │   ├── BitmapObjectFactory.as
│   │   │   ├── FontObjectFactory.as
│   │   │   ├── ILoaderConsumer.as
│   │   │   ├── IValueObjectFactory.as
│   │   │   ├── LoadOrder.as
│   │   │   ├── LoadProvider.as
│   │   │   ├── LoaderTest.as
│   │   │   ├── MultiFileVariables.as
│   │   │   ├── RSLObjectFactory.as
│   │   │   ├── SWFObjectFactory.as
│   │   │   ├── StringObjectFactory.as
│   │   │   └── UnloadCollection.as
│   │   └── values
│   │       ├── ReturnNumber.as
│   │       ├── ReturnString.as
│   │       └── ReturnValue.as
│   ├── debug
│   │   ├── CmdBtn.as
│   │   ├── ErrMsg.as
│   │   ├── TestButton.as
│   │   ├── TestButtonGroup.as
│   │   ├── console.as
│   │   ├── objstr.as
│   │   └── tostr.as
│   ├── framework
│   │   ├── data
│   │   │   └── CalendarData.as
│   │   ├── service
│   │   │   ├── DefaultFrameService.as
│   │   │   ├── DefaultPanelService.as
│   │   │   ├── DefaultTopService.as
│   │   │   ├── FlourSimpleLauncher.as
│   │   │   ├── IFrameService.as
│   │   │   ├── IPanelService.as
│   │   │   ├── ITopService.as
│   │   │   └── SS.as
│   │   ├── ss_internal.as
│   │   └── widgets
│   │       ├── btns
│   │       │   ├── Btn.as
│   │       │   ├── BtnConfig.as
│   │       │   ├── BtnInteraction.as
│   │       │   ├── BtnTest.as
│   │       │   ├── ClickBtnInteraction.as
│   │       │   ├── LableBtn.as
│   │       │   ├── asset
│   │       │   │   └── defaultButton
│   │       │   │       ├── action.png
│   │       │   │       ├── default.png
│   │       │   │       ├── disable.png
│   │       │   │       ├── over.png
│   │       │   │       └── selected.png
│   │       │   └── events
│   │       │       └── ClickEvent.as
│   │       ├── core
│   │       │   ├── IWidget.as
│   │       │   ├── InvalidSpriteWidget.as
│   │       │   ├── SpriteWidget.as
│   │       │   ├── Widget.as
│   │       │   ├── WidgetState.as
│   │       │   └── events
│   │       │       └── WidgetEvent.as
│   │       ├── input
│   │       │   ├── InputType.as
│   │       │   ├── TextArea.as
│   │       │   ├── TextAreaConfig.as
│   │       │   ├── TextInput.as
│   │       │   ├── TextWidget.as
│   │       │   ├── TextWidgetConfig.as
│   │       │   └── TextWidgetTest.as
│   │       ├── panels
│   │       │   ├── FlourAlert.as
│   │       │   ├── FlourConfirm.as
│   │       │   └── IPanelObject.as
│   │       ├── progress
│   │       ├── scroll
│   │       │   ├── Scroll.as
│   │       │   ├── ScrollConfig.as
│   │       │   ├── ScrollDirection.as
│   │       │   ├── ScrollTest.as
│   │       │   └── ScrollTrackMode.as
│   │       ├── selection
│   │       │   ├── ISelectionItem.as
│   │       │   ├── SelectionBtnInteraction.as
│   │       │   ├── SelectionGroup.as
│   │       │   └── events
│   │       │       └── SelectionEvent.as
│   │       ├── togglers
│   │       │   ├── IToggler.as
│   │       │   ├── ToggleBtnInteraction.as
│   │       │   └── events
│   │       │       └── ToggleEvent.as
│   │       └── visual
│   │           ├── DarkScreen.as
│   │           └── IValueVisual.as
│   └── styles
│       └── flour
│           ├── FlourTextFormatFactory.as
│           ├── boxes
│           │   ├── FlourWhiteBoxMaterial.as
│           │   ├── FlourWindowBoxMaterial.as
│           │   ├── FlourWindowTest.as
│           │   ├── white-disable-default.png
│           │   ├── white-run-default.png
│           │   ├── window-bg-run-default.png
│           │   └── window-inner-run-default.png
│           ├── btn
│           │   ├── FlourBtnStyleSet.as
│           │   ├── FlourCloseBtnMaterial.as
│           │   ├── close-disable-default.png
│           │   ├── close-run-default.png
│           │   ├── close-run-over.png
│           │   ├── disable-default.png
│           │   ├── run-default.png
│           │   ├── run-down.png
│           │   ├── run-over.png
│           │   ├── selected-default.png
│           │   ├── selected-down.png
│           │   └── selected-over.png
│           └── scroll
│               ├── FlourScrollBoxStyleSet.as
│               ├── FlourScrollStyleSet.as
│               ├── thumb-h-disable-default.png
│               ├── thumb-h-run-action.png
│               ├── thumb-h-run-default.png
│               ├── thumb-v-disable-default.png
│               ├── thumb-v-run-action.png
│               ├── thumb-v-run-default.png
│               ├── track-h-disable-default.png
│               ├── track-h-run-default.png
│               ├── track-v-disable-default.png
│               ├── track-v-run-default.png
│               ├── track-x-disable-default.png
│               └── track-x-run-default.png
└── test
    ├── DSArray2Test.as
    ├── DSBitVectorTest.as
    ├── DSDequeTest.as
    ├── DSHashMapTest.as
    ├── DSLinkedListTest.as
    ├── DSPoolTest.as
    ├── DSQueueTest.as
    ├── DSStackTest.as
    ├── KTweenTest.as
    ├── TLFTest.as
    └── UnicodeTest.as
```