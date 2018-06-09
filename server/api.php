<?php
	//Tabulky :	uzivatele (id AI, jmeno, helso)
	//			zbozi (id AI, nazev)
	//			obednavka (id AI, id_obednavky, id_zbozi, mozstvi)
	//			obednavky (id AI, id_majitele, datum, stav)

	// Spojení s databazí
	$mysqli = new mysqli('md14.wedos.net', 'a183248_chill', '6XaAmREV', 'd183248_chill');

	// Co se bude dít
	$action = isset( $_GET['action'] ) ? $_GET['action'] : "";
	// V jaký tabulce se to bude dít
	$table = isset( $_GET['table'] ) ? $_GET['table'] : "";	

	//id položky s kterou pracuju
	$get_id = isset( $_GET['id'] ) ? $_GET['id'] : "";
	//id nebo jmeno zakazníka
	$get_jmeno = isset( $_GET['jmeno'] ) ? $_GET['jmeno'] : "";
	//heslo uzivatele
	$get_heslo = isset( $_GET['heslo']) ? $_GET['heslo'] : "";
	//zemepisná šířka
	$sirka = isset( $_GET['sirka']) ? $_GET['sirka'] : "";
	//zemepisná délka
	$delka = isset( $_GET['delka']) ? $_GET['delka'] : "";
	//zemepisná délka
	$okruh = isset( $_GET['okruh']) ? $_GET['okruh'] : "";

header('Access-Control-Allow-Origin: *');
header("Content-Type:application/json");
header("HTTP/1.1 OK");

	switch( $action ){

		case 'login':
			login($mysqli, $get_jmeno, $get_heslo);
		break;

		case 'registr':
			registr($mysqli, $get_jmeno, $get_heslo);
		break;

		case 'reset_password':
			reset_password($mysqli, $get_jmeno, $get_heslo);
		break;		

		case 'around':
			getPlaceAroundSQL($mysqli, $sirka, $delka, $okruh);
		break;	

		case 'weather':
			getWether($sirka, $delka);
		break;	
 }

// ********************* Uživatel
 		//Kontrola přihlašeni
 			//?action=login&jmeno="derp"&heslo="kreslo"
 			//vrací objekt osoba
 		function login($mysqli, $get_jmeno, $get_heslo) {
		 	
 		}

 		//Registrace uživatele
 			//?action=registr&jmeno="derp" deslo="krslo"
 			//vrací OK nebo DUO při kolizi
		function registr($mysqli, $get_jmeno, $get_heslo) {
 			$vysledek = $mysqli->query("

				SELECT 'jmeno', 'heslo' FROM `user`
				
				      WHERE `jmeno`='".$get_jmeno."' && `heslo`='".$get_heslo."'
				LIMIT 1");

			$r = mysqli_fetch_assoc($vysledek);
			if ($r == null){
				echo("INSERT INTO `user` (`jmeno`, `heslo`) VALUES (".$get_jmeno.", ".$get_heslo.")");
				$mysqli->query("INSERT INTO `user` (`jmeno`, `heslo`) VALUES ('".$get_jmeno."', '".$get_heslo."')");
				print("OK");
			}else{
				print("DUO");
			}
 			$mysqli->close();
 		}

 		//Změní heslo uživatele
 			// ?action=buy&table=obednavka&jmeno="6" 6= id zakaznika
 			// vrátí "OK"
 		function reset_password($mysqli, $get_jmeno, $get_heslo, $table){
			$vysledek = $mysqli->query("UPDATE `user` SET  `heslo` = '".$get_heslo."' WHERE `jmeno` = ".$get_jmeno);
			print("OK");
			$mysqli->close();	
 		}


// ************************ Points
 		//Zjednodušení Quarry vstupem je přístup k DB a SQL
		function mQuarry ($mysqli, $sql){
			$mysqli->query("SET NAMES utf8");   
			$result = $mysqli->query($sql);     
			if (!$result) {
			  printf("Query failed: %s\n", $mysqli->error);
			  exit;
			}      
			while($row = $result->fetch_row()) {
			  $rows[]=$row;
			}
			$mysqli->close();
			return $rows;

		}

		//Porovnání aktualní polohy s SQL DB -> výpis mist v okruhu 1 km
		function getPlaceAroundSQL($mysqli, $point1_lat, $point1_long, $distance = 1)
		{
			$sub = mQuarry($mysqli, "SELECT * FROM `places` ORDER BY RAND()");
			foreach ($sub as $value) {
			    if ((getAround($point1_lat, $point1_long, $value['2'], $value['3'])) < 1){
					// (nutné zadat !!! API KEY !!!)
					//$value["stanice"] = selectDBWether($mysqli, $value['2'], $value['3'])['id'];
			    	$rows[] = $value;
			    };
			};
			$lol = array_slice($rows, 0, 5);
			print json_encode($lol);
		}

		//Vypočet vzdálenosti bodů
		function getAround($latitude1, $longitude1, $latitude2, $longitude2) {

			if (($latitude1 == $latitude2) && ($longitude1 == $longitude2)) { return 0; }
			$p1 = deg2rad($latitude1);
			$p2 = deg2rad($latitude2);
			$dp = deg2rad($latitude2 - $latitude1);
			$dl = deg2rad($longitude2 - $longitude1);
			$a = (sin($dp/2) * sin($dp/2)) + (cos($p1) * cos($p2) * sin($dl/2) * sin($dl/2));
			$c = 2 * atan2(sqrt($a),sqrt(1-$a));
			$r = 6371008; // Earth's average radius, in meters
			$d = $r * $c;
			return $d/1000; // distance, in meters
		}

		//Načtení počasí (nutné zadat !!! API KEY !!!)
		function getWether($point1_lat, $point1_long)
		{
			$string = file_get_contents("api.openweathermap.org/data/2.5/weather?lat=".$point1_lat."&lon=".$point1_long."&appid=7adec2c676fb517fb9748c06b499ff6e");
			$jsonIterator = new RecursiveIteratorIterator(
			    new RecursiveArrayIterator(json_decode($string, TRUE)),
			    RecursiveIteratorIterator::SELF_FIRST);

			foreach ($jsonIterator as $key => $val) {
				
			    if(is_array($val)) {
			    	 echo "Key: ".$key."<br />";
			    } else {
			         echo "Key: ".$key." Data: ".$data."<br />";
			    }
			} 
			return $jsonIterator;
		}
		
		function selectDBWether($mysqli, $point1_lat, $point1_long){
			$result = $mysqli->query("SELECT * FROM `wether` WHERE `lat` = '".round($point1_lat,0)."' and `lon`= '".round($point1_long,0)." LIMIT 1'");
			$rows = array();
			$r = mysqli_fetch_assoc($result);  
			while($row = $result->fetch_row()) {
			  $rows[]=$row;
			}
			return $rows;
			$mysqli->close();
		}




?>