package feathers.themes
{
	import com.zoe.composants.Boutonfiltre;
	import com.zoe.composants.Boutonmenu;
	
	import flash.desktop.Icon;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class ZoeMobileTheme extends MetalWorksMobileTheme
	{
		private static const COULEUR_GRIS:int=0xDCDCDC;
		private static const COULEUR_GRISFONCE:int=0x111111;
		private static const COULEUR_ORANGE:int=0xFFB600;
		private static const COULEUR_ROUGE:int=0xFF0000;
		
		private static const COULEUR_LABGRISFONCE:int=0x3A3A39;
		
		
		public static const ROOT_COPYRIGHT:String ="ROOT_COPYRIGHT";
		public static const ROOT_LABVERSION:String ="ROOT_LABVERSION";
		public static const ROOT_LABPRG:String="ROOT_LABPRG";
		
		public static const POPUNET_TITRE1:String ="popupnet_titre1";
		public static const POPUNET_TITRE2:String ="popupnet_titre2";
		public static const POPUPNET_BTN:String="popupnet_btn";
		
		public static const CARTOMENU_TITRE:String="CARTOMENU_TITRE";
		public static const BOUTONMENU_TITRE:String="BOUTONMENU_TITRE";
		
		
		public static const BOUTON_BACK:String="bouton_back";
		public static const LABEL_ICO:String="label_ico";
		public static const ACTULABELNOMSHOP:String="ACTULABELNOMSHOP";
		public static const ACTULABELDATEMSG:String="ACTULABELDATEMSG";
		public static const ACTULABELFC:String="ACTULABELFC";
		public static const ACTULABELDESC:String="ACTULABELDESC";
		public static const ACTULABELVALID:String="ACTULABELVALID";
		public static const ACTULABELVALIDDUAU:String="ACTULABELVALIDDUAU";
		
		public static const ACTUBTNGRIS:String="ACTUBTNGRIS";
		public static const ACTUBTNORANGE:String="ACTUBTNORANGE";
		public static const ACTUBTNBLANC:String="ACTUBTNBLANC";
		
		public static const MESCOMRECHERCHE:String="MESCOMRECHERCHE";
		
		public static const MESADRESSESTITRE:String="MESADRESSESTITRE";
		public static const MESADRESSESLIB:String="MESADRESSESLIB";
		public static const MESADRESSESLIBVIDE:String="MESADRESSESLIBVIDE";
		public static const MESADRESSESTITREDER:String="MESADRESSESTITREDER";
		
		public static const SAISIRADRESSESTITRE:String="SAISIRADRESSESTITRE";
		
		public static const TUTOLABEL:String ="TUTOLABEL";
		public static const TUTOBTNORANGE:String="TUTOBTNORANGE";
		
		public static const IDENTIFICATIONLABHAUT:String ="IDENTIFICATIONLABHAUT";
		public static const IDENTIFICATIONLABFB:String ="IDENTIFICATIONLABFB";
		public static const IDENTIFICATIONLABM:String ="IDENTIFICATIONLABM";
		public static const IDENTIFICATIONLABDEJA:String ="IDENTIFICATIONLABDEJA";
		
		
		public static const IDENTIFICATIONINPUT:String ="IDENTIFICATIONINPUT";
		public static const IDENTIFICATIONERROR:String ="IDENTIFICATIONERROR";
		public static const IDENTIFICATIOMAILMANQUANT:String ="IDENTIFICATIOMAILMANQUANT";
		public static const IDENTIFICATIOMAILVALIDER:String ="IDENTIFICATIOMAILVALIDER";
		public static const IDENTIFICATIONBTNNOIR:String ="IDENTIFICATIONBTNNOIR";
		
		
		public static const COMMONBTNCHEVRON:String ="COMMONBTNCHEVRON";
		public static const COMMONBTNCLOSE:String ="COMMONBTNCLOSE";
		public static const COMMONLABHDRMENU:String ="COMMONLABHDRMENU";
		public static const COMMONLABNOCO:String ="COMMONLABNOCO";
		
		
		public static const FICHECONOM:String ="FICHECONOM";
		public static const FICHECOLABTYPE:String ="FICHECOLABTYPE";
		public static const FICHECOADRESSE:String ="FICHECOADRESSE";
		public static const FICHECOHORAIRE:String ="FICHECOHORAIRE";
		public static const FICHECODESCTITRE:String ="FICHECODESCTITRE";
		public static const FICHECODESC:String ="FICHECODESC";
		public static const FICHECOBTNTEL:String ="FICHECOBTNTEL";
		public static const FICHECOCARTEFID:String ="FICHECOCARTEFID";
		public static const FICHECOVOIRCARTEFID:String ="FICHECOVOIRCARTEFID";
		public static const FICHECORECEVOIRALERTE:String ="FICHECORECEVOIRALERTE";
		public static const FICHECOBTNSUIVRE:String ="FICHECOBTNSUIVRE";
		public static const FICHECOBTNNOSUIVRE:String ="FICHECOBTNNOSUIVRE";
		public static const FICHECOBTNMSG:String ="FICHECOBTNMSG";

		public static const CARTEFIDTYPE:String ="CARTEFIDTYPE";
		public static const CARTEFIDVOIR:String ="CARTEFIDVOIR";
		public static const CARTEFIDCGU:String ="CARTEFIDCGU";
		public static const CARTEFIDPRESENTER:String ="CARTEFIDPRESENTER";
		public static const CARTEFIDTPNOK:String ="CARTEFIDTPNOK";
		public static const CARTEFIDTPNKO:String ="CARTEFIDTPNKO";
		public static const CARTEFIDCLAVIER:String ="CARTEFIDCLAVIER";
		public static const CARTEFIDCLAVIERC:String ="CARTEFIDCLAVIERC";
		public static const CARTEFIDERROR:String ="CARTEFIDERROR";
		
		public static const CARTEFIDVALIDESECRET:String ="CARTEFIDVALIDESECRET";
		
		
		
		public function ZoeMobileTheme(root:DisplayObjectContainer)
		{
			// super(root);
		}
		override protected function initialize():void
		{
			super.initialize();
			
			// set new initializers here
			this.setInitializerForClass(Button, commonbtnchevron, COMMONBTNCHEVRON);
			this.setInitializerForClass(Button, commonbtnclose, COMMONBTNCLOSE);
			this.setInitializerForClass(Label, commonlabhdrmenu, COMMONLABHDRMENU);
			this.setInitializerForClass(Label, commonlabnoco, COMMONLABNOCO);
			
			
			this.setInitializerForClass(Label, labelrootcopyright, ROOT_COPYRIGHT);
			this.setInitializerForClass(Label, labelrootlabversion, ROOT_LABVERSION);
			this.setInitializerForClass(Label, labelrootlabprg, ROOT_LABPRG);
			
			
			this.setInitializerForClass(Label, labelpopunettitre1, POPUNET_TITRE1);
			this.setInitializerForClass(Label, labelpopunettitre2, POPUNET_TITRE2);
			
			this.setInitializerForClass(Button, buttonpopupnetbtn, POPUPNET_BTN);
			
			
			this.setInitializerForClass(Label, labelcartomenutitre, CARTOMENU_TITRE);
			this.setInitializerForClass(Label, labelboutonmenutitre, BOUTONMENU_TITRE);
			
			this.setInitializerForClass(Button, buttonback, BOUTON_BACK);
			this.setInitializerForClass(Label, labelico, LABEL_ICO);
			this.setInitializerForClass(Label, actulabelnomshop, ACTULABELNOMSHOP);
			this.setInitializerForClass(Label, actulabeldatemsg, ACTULABELDATEMSG);
			this.setInitializerForClass(Label, actulabelfc, ACTULABELFC);
			this.setInitializerForClass(Label, actulabeldesc, ACTULABELDESC);
			this.setInitializerForClass(Label, actulabelvalid, ACTULABELVALID);
			this.setInitializerForClass(Label, actulabelvalidduau, ACTULABELVALIDDUAU);
			this.setInitializerForClass(Button, actubtngris, ACTUBTNGRIS);
			this.setInitializerForClass(Button, actubtnblanc, ACTUBTNBLANC);
			this.setInitializerForClass(Button, actubtnorange, ACTUBTNORANGE);
			
			this.setInitializerForClass(TextInput, commerceinput,MESCOMRECHERCHE);
			
			this.setInitializerForClass(Label, mesadressestitre, MESADRESSESTITRE);
			this.setInitializerForClass(Label, mesadresseslib, MESADRESSESLIB);
			this.setInitializerForClass(Label, mesadresseslibvide, MESADRESSESLIBVIDE);
			this.setInitializerForClass(Label, saisiradressestitre, SAISIRADRESSESTITRE);
			this.setInitializerForClass(Label, mesadressestitreder, MESADRESSESTITREDER);
			
			
			this.setInitializerForClass(Label, tutolabel, TUTOLABEL);
			this.setInitializerForClass(Button, tutobtnorange, TUTOBTNORANGE);
			
			
			this.setInitializerForClass(Label, identificationlabhaut, IDENTIFICATIONLABHAUT);
			this.setInitializerForClass(Label, identificationlabfb, IDENTIFICATIONLABFB);
			this.setInitializerForClass(Label, identificationlabm, IDENTIFICATIONLABM);
			this.setInitializerForClass(Label, identificationlabdeja, IDENTIFICATIONLABDEJA);
			this.setInitializerForClass(TextInput, identifcationiput, IDENTIFICATIONINPUT);
			this.setInitializerForClass(Label, identificationerror, IDENTIFICATIONERROR);
			this.setInitializerForClass(Button, identificationmailmanquant, IDENTIFICATIOMAILMANQUANT);
			this.setInitializerForClass(Button, identificationbtnnoir, IDENTIFICATIONBTNNOIR);
			
			
			this.setInitializerForClass(Label, fichecocom, FICHECONOM);
			this.setInitializerForClass(Label, fichecolabtype, FICHECOLABTYPE);
			this.setInitializerForClass(Label, fichecoadresse, FICHECOADRESSE);
			this.setInitializerForClass(Label, fichecohoraire, FICHECOHORAIRE);
			this.setInitializerForClass(Label, fichecodesctitre, FICHECODESCTITRE);
			this.setInitializerForClass(Label, fichocodesc, FICHECODESC);
			this.setInitializerForClass(Button, fichecobtntel, FICHECOBTNTEL);
			this.setInitializerForClass(Label, fichecocartefid, FICHECOCARTEFID);
			this.setInitializerForClass(Label, fichecovoircartefid, FICHECOVOIRCARTEFID);
			this.setInitializerForClass(Label, fichecovoiralerte, FICHECORECEVOIRALERTE);
			this.setInitializerForClass(Button, fichecobtnsuivre, FICHECOBTNSUIVRE);
			this.setInitializerForClass(Button, fichecobtnnosuivre, FICHECOBTNNOSUIVRE);
			this.setInitializerForClass(Button, fichecobtnmsg, FICHECOBTNMSG);

			this.setInitializerForClass(Boutonfiltre, boutonfiltre);
			this.setInitializerForClass(Boutonmenu, boutonmenu);

			this.setInitializerForClass(Label, cartefidtype, CARTEFIDTYPE);
			this.setInitializerForClass(Label, cartefidvoir, CARTEFIDVOIR);
			this.setInitializerForClass(Label, cartefidcgu, CARTEFIDCGU);
			this.setInitializerForClass(Label, cartefidpresenter, CARTEFIDPRESENTER);
			this.setInitializerForClass(Button, cartefidtpnko, CARTEFIDTPNKO);
			this.setInitializerForClass(Button, cartefidtpnok, CARTEFIDTPNOK);
			this.setInitializerForClass(Button, cartefidclavier, CARTEFIDCLAVIER);
			this.setInitializerForClass(Button, cartefidclavierc, CARTEFIDCLAVIERC);
			this.setInitializerForClass(Label, cartefiderror, CARTEFIDERROR);
			
			this.setInitializerForClass(Label, cartefidvalidesecret, CARTEFIDVALIDESECRET);
			
		}
		private function cartefidvalidesecret(label:Label):void
		{
			var zz:TextFormat=new TextFormat("Arial", 20, 0x000000,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
		}
		private function identifcationiput(input:TextInput):void
		{
			
			input.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(10,10,80,5)));
			input.backgroundFocusedSkin=input.backgroundSkin;
			input.backgroundDisabledSkin=input.backgroundSkin;
			input.textEditorProperties.fontFamily = "Arial";
			input.textEditorProperties.fontSize = 12;
			input.textEditorProperties.color = 0x000000;
			input.paddingLeft = 10;
			input.promptProperties.textFormat = new TextFormat("Arial", 12, 0xDCDCDC,false,true);
			
			//		input.backgroundSkin = new Scale9Image( new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
			//		input.backgroundDisabledSkin = new Scale9Image( new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
			//		input.backgroundFocusedSkin = new Scale9Image(new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
		}
		private function commerceinput(input:TextInput):void
		{
			
			input.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(10,10,80,5)));
			input.backgroundFocusedSkin=input.backgroundSkin;
			input.backgroundDisabledSkin=input.backgroundSkin;
			input.textEditorProperties.fontFamily = "Arial";
			input.textEditorProperties.fontSize = 12;
			input.textEditorProperties.color = 0x000000;
			input.paddingLeft = 10;
			input.promptProperties.textFormat = new TextFormat("Arial", 12, 0xDCDCDC,false,true);
			
			//		input.backgroundSkin = new Scale9Image( new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
			//		input.backgroundDisabledSkin = new Scale9Image( new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
			//		input.backgroundFocusedSkin = new Scale9Image(new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(0,0,50,10)));
		}
		
		private function labelrootcopyright(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat("Pacifico", 12, COULEUR_GRIS,false);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function labelrootlabversion(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat("Pacifico", 12, COULEUR_GRIS,false);
			zz.align=TextFormatAlign.RIGHT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function labelrootlabprg( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, COULEUR_ORANGE,true);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = false;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}		
		private function commonlabhdrmenu( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Pacifico", 16, 0xFFFFFF,false);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = false;
			label.textRendererProperties.textFormat = zz;			
			label.textRendererProperties.embedFonts=true;
		}
		private function commonlabnoco( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, 0xFFFFFF,false);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = false;
			label.textRendererProperties.textFormat = zz;			
//			label.textRendererProperties.embedFonts=true;
		}
		
		private function tutolabel(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Pacifico", 22, 0xFFFFFF,false);
			zz.leading=-10;
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
			//			label.textRendererProperties.embedFonts=true;
		}
		
		private function identificationlabhaut(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 14, 0x000000,true);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//			label.textRendererProperties.embedFonts=true;
			label.textRendererProperties.embedFonts=true;
		}
		private function identificationlabm(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, 0x000000,true);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		
		private function identificationlabdeja(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, 0x000000,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		
		private function identificationlabfb(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, COULEUR_GRISFONCE,false,true);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function identificationerror(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, COULEUR_ROUGE,true,true);
			zz.align=TextFormatAlign.LEFT;
			label.height=10;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function cartefiderror(label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 14, COULEUR_ROUGE,true,true);
			zz.align=TextFormatAlign.CENTER;
//			label.height=12;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		
		private function labelpopunettitre1( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 22, 0x000000, true);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function labelpopunettitre2( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0x3a3a39,false);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function labelico( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 14, 0xFFFFFF,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function actulabelnomshop( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0x000000,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function actulabeldatemsg( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10,COULEUR_GRISFONCE,true,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function actulabelfc( label:Label):void
		{
			//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 9,COULEUR_GRISFONCE,true,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//			label.textRendererProperties.embedFonts=true;
		}
		private function actulabeldesc( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0xFFFFFF,true,true);
			zz.align=TextFormatAlign.LEFT;
			zz.italic=true;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function actulabelvalid( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 11, COULEUR_GRISFONCE,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function actulabelvalidduau( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, COULEUR_GRISFONCE,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function mesadressestitre( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0x000000,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function mesadressestitreder(label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0xFFFFFF,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function saisiradressestitre( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 16, 0xFFFFFF,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function mesadresseslib( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, 0x000000,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function mesadresseslibvide( label:Label):void
		{
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, 0x000000,false,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		
		private function labelcartomenutitre( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Pacifico", 14, 0x3a3a39,false);
			zz.leading=-10;
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;			
			label.textRendererProperties.embedFonts=true;
		}
		private function labelboutonmenutitre( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Pacifico", 11, 0x3a3a39,false);
			zz.leading=-10;
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		
		private function buttonpopupnetbtn( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnnoir"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;			
			var ztf:TextFormat=new TextFormat("Pacifico", 20, 0xFFFFFF,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function actubtngris( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btngris"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;			
			var ztf:TextFormat=new TextFormat("Pacifico", 12, 0xFFFFFF,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function actubtnblanc( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;			
			var ztf:TextFormat=new TextFormat("Pacifico", 12, COULEUR_GRISFONCE,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function actubtnorange( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnorange"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;			
			var ztf:TextFormat=new TextFormat("Pacifico", 12, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		
		private function tutobtnorange(button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnorange"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -2;			
			var ztf:TextFormat=new TextFormat("Pacifico", 13, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		
		private function identificationmailmanquant(button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -2;
			var ztf:TextFormat=new TextFormat("Pacifico", 10, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function identificationbtnnoir(button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnnoir"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -1;
			var ztf:TextFormat=new TextFormat("Pacifico", 14, 0xFFFFFF,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		
		private function buttonback( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btnretour"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			//button.labelOffsetY = -2;
			var ztf:TextFormat=new TextFormat("Arial", 12, 0x000000,true);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
			
			
			/*			button.labelOffsetY = -5;			
			var ztf:TextFormat=new TextFormat("Pacifico", 20, 0xFFFFFF,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		*/		}
		
		private function commonbtnchevron(button:Button ):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("chevronmessage"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
		}
		private function commonbtnclose(button:Button ):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("closemenu"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
		}
		
		/////////
		
		private function fichecocom(label:Label):void
		{//ok
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 17, 0x000000,true,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function fichecolabtype(label:Label):void
		{//ok
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat("Arial", 10, COULEUR_LABGRISFONCE,true,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function fichecoadresse(label:Label):void
		{//ok
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 9, COULEUR_LABGRISFONCE,false,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function fichecohoraire(label:Label):void
		{//ok
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 8, COULEUR_LABGRISFONCE,false,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function fichecodesctitre(label:Label):void
		{//ok
			//super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 9, COULEUR_LABGRISFONCE,true,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//label.textRendererProperties.embedFonts=true;
		}
		private function fichocodesc(label:Label):void
		{//ok
			//super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 8, COULEUR_LABGRISFONCE,false,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//label.textRendererProperties.embedFonts=true;
		}
		private function fichecobtntel(button:Button):void
		{//ok	
			button.defaultSkin = new Image(Root.assets.getTexture("tel"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -1;
			button.labelOffsetX = 8;
			var ztf:TextFormat=new TextFormat("Arial", 10.5, 0x000000,true);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		
		private function fichecocartefid(label:Label):void
		{//ok
			//super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, COULEUR_LABGRISFONCE,true,true);
			zz.align=TextFormatAlign.LEFT;
			zz.leftMargin=20;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
	//		label.textRendererProperties.embedFonts=true;
		}
		private function fichecovoircartefid(label:Label):void
		{//ok
			//super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 8, COULEUR_LABGRISFONCE,true,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//label.textRendererProperties.embedFonts=true;
		}
		private function fichecovoiralerte(label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 8, COULEUR_LABGRISFONCE,true,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.embedFonts=true;
		}
		private function cartefidtpnko( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btncarreblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			var ztf:TextFormat=new TextFormat("Pacifico", 12, 0x000000,false);
			ztf.align=TextFormatAlign.CENTER;
			button.defaultLabelProperties.wordWrap = true;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function cartefidclavier( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btncarreblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;
			var ztf:TextFormat=new TextFormat("Pacifico", 40, 0x000000,false);
			ztf.align=TextFormatAlign.CENTER;
			button.defaultLabelProperties.wordWrap = true;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function cartefidclavierc( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btncarreblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -5;
			var ztf:TextFormat=new TextFormat("Pacifico", 20, 0x000000,false);
			ztf.align=TextFormatAlign.CENTER;
			button.defaultLabelProperties.wordWrap = true;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function cartefidtpnok( button:Button ):void
		{
			//			super.buttonInitializer(button);
			//			button.useHandCursor=true;
			button.defaultSkin = new Image(Root.assets.getTexture("btncarrenoir"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.defaultIcon=new Image(Root.assets.getTexture("favori"));
			button.iconPosition=Button.ICON_POSITION_TOP;
			//button.labelOffsetY = ;			
			var ztf:TextFormat=new TextFormat("Arial", 9, 0xFFFFFF,true);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}

		
		private function fichecobtnsuivre(button:Button):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("btnblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -2;
			var ztf:TextFormat=new TextFormat("Pacifico", 14, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function fichecobtnnosuivre(button:Button):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("btnblanc"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.labelOffsetY = -2;
			var ztf:TextFormat=new TextFormat("Pacifico", 12, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function fichecobtnmsg(button:Button):void
		{
			button.defaultSkin = new Image(Root.assets.getTexture("mail"));// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=button.hoverSkin;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			
		//	button.labelOffsetY = -2;
			var ztf:TextFormat=new TextFormat("Pacifico", 10, 0x000000,false);
			button.defaultLabelProperties.wordWrap = false;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function cartefidtype(label:Label):void
		{//ok
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat("Arial", 14, COULEUR_LABGRISFONCE,true,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function cartefidvoir(label:Label):void
		{//ok
//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, 0x000000,false,true);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = false;
			label.textRendererProperties.textFormat = zz;
//			label.textRendererProperties.embedFonts=true;
		}
		private function cartefidpresenter(label:Label):void
		{//ok
			//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 12, 0xFFFFFF,false,false);
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//			label.textRendererProperties.embedFonts=true;
		}
		
		private function cartefidcgu(label:Label):void
		{//ok
			//			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Arial", 10, 0x000000,false,false);
			zz.align=TextFormatAlign.LEFT;
			label.textRendererProperties.wordWrap = true;
			label.textRendererProperties.textFormat = zz;
			//			label.textRendererProperties.embedFonts=true;
		}
		
		private function boutonfiltre(button:Boutonfiltre):void
		{
			button.defaultSelectedSkin= new Image(Root.assets.getTexture("btncarreblancpictoon"));// new Image( buttonSelectedDownSkinTextures );
			button.defaultSelectedIcon=new Image(Root.assets.getTexture(""+button.lid));

			//			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.downSkin=new Image(Root.assets.getTexture("btncarreblancpictooff"));			
//			button.selectedUpIcon=new Image(Root.assets.getTexture(""+button.lid));
			
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.iconPosition=Button.ICON_POSITION_TOP;
			button.labelOffsetY = -2;
			
			button.width=90;
			button.height=90;
			var ztf:TextFormat=new TextFormat("Pacifico", 14, 0x000000,false);
			ztf.leading=-5;
			ztf.align=TextFormatAlign.CENTER;
			button.defaultLabelProperties.wordWrap = true;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.width=90;
			button.defaultLabelProperties.textFormat =ztf ;
		}
		private function boutonmenu(button:Boutonmenu):void
		{
			button.defaultSelectedSkin= new Image(Root.assets.getTexture("btncarreblanc"));// new Image( buttonSelectedDownSkinTextures );
			switch (button.idmenu){
				case Boutonmenu.BOUTONMENU_ADRESSES:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictoadresse"));
					break;
				case Boutonmenu.BOUTONMENU_CARTEFIDELITE:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictofid"));
					break;
				case Boutonmenu.BOUTONMENU_CHERCHERADRESSE:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictochercher"));
					break;
				case Boutonmenu.BOUTONMENU_COMMERCANTS:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictocommercants"));
					break;
				case Boutonmenu.BOUTONMENU_MESSAGES:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictomessage"));
					break;
				case Boutonmenu.BOUTONMENU_PROFIL:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictoprofil"));
					break;
				case Boutonmenu.BOUTONMENU_TUTORIAL:
					button.defaultSelectedIcon=new Image(Root.assets.getTexture("menupictotuto"));
					break;
			}			

			//			button.hoverSkin = button.defaultSkin;//new Image(this.atlas.getTexture("rollamiesquijouentaujeu"));// new Image( buttonSelectedDownSkinTextures );
			button.selectedDownSkin=new Image(Root.assets.getTexture("btncarreblancpictooff"));			
			//			button.selectedUpIcon=new Image(Root.assets.getTexture(""+button.lid));
			
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			button.iconPosition=Button.ICON_POSITION_TOP;
			button.labelOffsetY = -2;
			button.width=90;
			button.height=90;
			var ztf:TextFormat=new TextFormat("Pacifico", 15, 0x000000,false);
			ztf.leading=-5;
			ztf.align=TextFormatAlign.CENTER;
			button.defaultLabelProperties.width=90;
			button.defaultLabelProperties.wordWrap = true;
			button.defaultLabelProperties.embedFonts=true;
			button.defaultLabelProperties.textFormat =ztf ;
		}

	}
}