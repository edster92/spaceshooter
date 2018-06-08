using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using System.Collections;
using System.Xml;
using System.Xml.Serialization;

public class Done_GameController : MonoBehaviour
{
	public event System.Action AllDead;
	public GameObject[] hazards;
    public GameObject[] bonuses;
	[SerializeField]
	GameObject bomb;
	public Vector3 spawnValues;
	public int hazardCount;
    public int bonusCount;
    public float spawnWait;
	public float startWait;
	public float waveWait;
    public static Done_GameController Instance;
	public float Xmin, Xmax;





    public GUIText scoreText;
	public GUIText restartText;
	public GUIText gameOverText;

    public GUIText HealthText;


    private bool gameOver;
	private bool restart;
	private int score;
    [SerializeField]
    float minTimeSpawnBonus, maxTimeSpawnBonus;
    Transform GOparant;
	public BaseWeapon[] Weapons;

    public PlayerController Player;

	float alpha = 0;

	
	void Start ()
	{
		gameOver = false;
		restart = false;
		restartText.text = "";
		restartText.color = Color.clear;
		gameOverText.color = Color.clear;
		gameOverText.text = "";
		score = 0;
		UpdateScore ();
	//	UpdateHealth ();

        GOparant = new GameObject("GOparant").transform;

		if (Screen.height > Screen.width) 
		{
			Xmin = -4.5f;
			Xmax = 4.5f;
			spawnValues = new Vector3 (Random.Range (-4.5f, 4.5f), spawnValues.y, spawnValues.z);
		}

	}

    void Awake ()
    {
        Done_GameController.Instance = this;
    }
	
	void Update ()
	{
		if (gameOver)
		{
			restartText.text = "Press 'R' for Restart";
			restartText.color = new Color (1, 1, 1, alpha); 
			alpha += Time.deltaTime * 0.5f;
			restart = true;
			gameOverText.color = new Color (1, 1, 1, alpha);
		}
		if (restart)
		{
			if (Input.GetKeyDown (KeyCode.R))
			{
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
			}
		}
	}

	public void StartGame ()
	{
		Player.gameObject.SetActive (true);
		StartCoroutine (SpawnWaves ());
		StartCoroutine(SpawnBonus());
		StartCoroutine (SpawnBomb ());
	}


	IEnumerator SpawnWaves ()
	{
		yield return new WaitForSeconds (startWait);
		while (true)
		{
            for (int i = 0; i < hazardCount; i++)
            {
                GameObject hazard = hazards[Random.Range(0, hazards.Length)];
                Vector3 spawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
                Quaternion spawnRotation = Quaternion.identity;
				Instantiate (hazard, spawnPosition, spawnRotation, GOparant);
                yield return new WaitForSeconds(spawnWait);
            } 
			           			
			yield return new WaitForSeconds (waveWait);
		}
	}
	
    IEnumerator SpawnBonus ()
    {
        yield return new WaitForSeconds(Random.Range(minTimeSpawnBonus, maxTimeSpawnBonus));
        while (true)
        {
            GameObject bonus = bonuses[Random.Range(0, bonuses.Length)];
            Vector3 bonuSpawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
            Quaternion bonusSpawnRotation = Quaternion.identity;
            Instantiate(bonus, bonuSpawnPosition, bonusSpawnRotation, GOparant);
            yield return new WaitForSeconds(Random.Range(minTimeSpawnBonus, maxTimeSpawnBonus));
        }
    }
	IEnumerator SpawnBomb ()
	{
		yield return new WaitForSeconds(Random.Range(25, 50));
		while (true)
		{
			Vector3 bombSpawnPosition = new Vector3 (Random.Range (-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
			Quaternion bombSpawnRotation = Quaternion.identity;
			Instantiate (bomb, bombSpawnPosition, bombSpawnRotation, GOparant);
			yield return new WaitForSeconds (Random.Range (10, 15));
		}
		yield break;
	}

	public void AddScore (int newScoreValue)
	{
		score += newScoreValue;
		UpdateScore ();
	}

	
	void UpdateScore ()
	{
		scoreText.text = "Score: " + score;
	}

	public void UpdateHealth(float HealthPoints)
    {
		HealthText.text = "Health: " + HealthPoints;
    }

    public void GameOver ()
	{
		gameOverText.text = "Game Over!";
		gameOver = true;
        StopAllCoroutines();
	}
    public void AddBonus(BonusContainer Container)
	{
		switch (Container.BonusType) {

		case BonusContainer.ChoseBonusType.HelathPonts:
			{
				Player.HealthPoints += Container.BonusQuantity;
				break;
			}
		case BonusContainer.ChoseBonusType.Immortality:
			{
				Player.AddImmoratl ((float)Container.BonusQuantity);
				break;
			}
		case BonusContainer.ChoseBonusType.Weapon:
			{
				if (Player.Weapon.Type != Container.WeaponType) {
					bool playerShoted = false;
					if (Player.Weapon.fireOn == true) {
						Player.Weapon.FireEnd ();
						playerShoted = true;
					}
					
					foreach (BaseWeapon wip in Weapons) {

						if (wip.Type == Container.WeaponType) {
							Player.Weapon = wip;
							break;
						}
					}
					if (playerShoted == true)
						Player.Weapon.FireStart ();
				} else if (Player.Weapon.WeaponLevel == Player.Weapon.MaxWeaponLevel)
					return;
				else
					Player.Weapon.WeaponLevelsUp ();
				break;
			}
		case BonusContainer.ChoseBonusType.GreatBaBah:
			{
				if (AllDead != null)
					AllDead ();
				break;
			}
		}
	}

	public void SpawnEnemy ()
	{
		GameObject hazard = hazards[Random.Range(0, hazards.Length)];
		Vector3 spawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
		Quaternion spawnRotation = Quaternion.identity;
		Instantiate (hazard, spawnPosition, spawnRotation, GOparant);
	}
	public void SpawnLaser ()
	{
		GameObject bonus = bonuses[Random.Range(0, bonuses.Length)];
		Vector3 bonuSpawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
		Quaternion bonusSpawnRotation = Quaternion.identity;
		Instantiate(bonus, bonuSpawnPosition, bonusSpawnRotation, GOparant);
	}
	public void SpawnSS ()
	{
	}
	public void SpawnMS ()
	{
	}
	public void SpawnBombss ()
	{
		Vector3 bombSpawnPosition = new Vector3 (Random.Range (-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
		Quaternion bombSpawnRotation = Quaternion.identity;
		Instantiate (bomb, bombSpawnPosition, bombSpawnRotation, GOparant);
	}
	public void QuiyGame ()
	{
		Application.Quit ();
	}
}