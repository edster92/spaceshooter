using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaveController : MonoBehaviour {

	[SerializeField]
	float timeBetwenWaves;
	[SerializeField]
	List <Wave> waves = new List<Wave> ();
	float timeToSpawn;
	Transform GOparant1;
	[SerializeField]
	Vector3 spawnValues;

	void Start ()
	{
		GOparant1 = new GameObject("GOparant1").transform;
	}

	IEnumerator wavesHandler ()
	{
		for (int i = 0; i < waves.Count; i++) {
			timeToSpawn = Time.time + Random.Range (waves [i].minTimeSpawn, waves [i].maxTimeSpawn);
			while (true) {
				if (timeToSpawn <= Time.time) {
					int U = Random.Range (0, waves [i].WaveUnits.Count - 1);

					Vector3 spawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
					Quaternion spawnRotation = Quaternion.identity;
					Instantiate (waves [i].WaveUnits [U].unit, spawnPosition, spawnRotation); // здесь будем вызывать спаун U юнита "waves [i].waveUnit [U].unit, отдельным класом

					waves [i].WaveUnits[U].unitQuantity--;
					if (waves [i].WaveUnits [U].unitQuantity == 0)
						waves [i].WaveUnits.RemoveAt (U);
					if (waves [i].WaveUnits.Count == 0)
						break;
					timeToSpawn = Time.time + Random.Range (waves [i].minTimeSpawn, waves [i].maxTimeSpawn);
				}
				yield return null;
			}
		}
	}

	public void StartWaves ()
	{
		StartCoroutine (wavesHandler ());
	}


//	public void SpawnUnit ()
//	{
//		Vector3 spawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), spawnValues.y, spawnValues.z);
//		Quaternion spawnRotation = Quaternion.identity;
//		Instantiate (waves [1].WaveUnits[1], spawnPosition, spawnRotation, GOparant);
//	}
}
