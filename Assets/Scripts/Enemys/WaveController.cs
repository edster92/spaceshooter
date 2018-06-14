using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaveController : MonoBehaviour {

	[SerializeField]
	float timeBetwenWaves;
	[SerializeField]
	List <Wave> waves = new List<Wave> ();
	float timeToSpawn;

	IEnumerator wavesHandler ()
	{
		for (int i = 0; i < waves.Count; i++) {
			timeToSpawn = Time.time + Random.Range (waves [i].minTimeSpawn, waves [i].maxTimeSpawn);
			while (true) {
				if (timeToSpawn <= Time.time) {
					int U = Random.Range (0, waves [i].WaveUnits.Count - 1);
					// здесь будем вызывать спаун U юнита "waves [i].waveUnit [U].unit 
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
}
