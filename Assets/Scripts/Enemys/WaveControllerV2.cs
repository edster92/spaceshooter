using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaveControllerV2 : MonoBehaviour {
    public enum SpawnState { SPAWNING, WAITING, COUNTING };

    [System.Serializable]
    public class waveUnit
    {
        public string name;
        public Transform enemy;
        public int count;
        public float rate;
    }

    public waveUnit[] waves;
    int nextWave = 0;
    public float timeBetwenWaves = 5f;
    public float waveCountDown;

    private SpawnState state = SpawnState.COUNTING;

    void Start ()
    {
        waveCountDown = timeBetwenWaves;
    }

    void Update ()
    {
        if (state != SpawnState.SPAWNING)
        {
            StartCoroutine(SpawnWave(waves[nextWave]));
        }
        else
        {
            waveCountDown -= Time.deltaTime;
        }
    }

    IEnumerator SpawnWave (waveUnit _wave)
    {
        state = SpawnState.SPAWNING;
        for (int i = 0; i<_wave.count; i++)
        {

        }
        state = SpawnState.WAITING;
        yield break;
    }

    void SpawnEnemy (Transform _enemy)
    {
        //SpawnEnemy
        Debug.Log("Spawning enemy: " + _enemy.name);
    }

}
