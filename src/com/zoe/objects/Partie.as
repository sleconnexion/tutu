package com.zoe.objects
{
	import flash.media.StageWebView;
	
	import starling.display.Image;

	public class Partie
	{
		public function Partie()
		{
		}
		// objet renvoyé par le serveur au foramt json contient les questions
		public var carto:StageWebView;
		public var idshop:String;
		public var nomshop:String;
		public var datebloque:String;
		
		public var fromscreen:String;
		public var typedata:String;
		public var typenav:uint;
		
		
		public var dataquizz:Object;
		public var prenom:String;
		public var score:uint;
		public var points:uint;
		public var bonus:Boolean;
		public var phrase:String;
		public var idpartie:uint;
		public var solo:Number=0;

		public var idgauche:Number=1;
		public var iddroite:Number=1;
		public var prenomgauche:String="";
		public var prenomdroite:String="";
		public var scoregauche:String= "";
		public var scoredroite:String= "";		
		public var fromjeu:uint=0;

	}
}