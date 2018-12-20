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
    float searchCoundown = 1f;

    private SpawnState state = SpawnState.COUNTING;

    void Start ()
    {
        waveCountDown = timeBetwenWaves;
    }

    void Update ()
    {
        if (state == SpawnState.WAITING)
        {
            if (!EnemyIsAlive)
            {
                // begin new round
                Debug.Log("Wave compleated");
            }
            else
            {
                return;
            }
        }

        if (waveCountDown <= 0)
        {
            if (state != SpawnState.SPAWNING)
            {
                StartCoroutine(SpawnWave(waves[nextWave]));
            }
        }

        else
        {
            waveCountDown -= Time.deltaTime;
        }
    }

    bool EnemyIsAlive ()
    {
        searchCoundown -= Time.deltaTime;
        if (searchCoundown <= 0f)
        {
            searchCoundown = 1f;
            if (GameObject.FindGameObjectWithTag("Enemy") == null)
            {
                return false;
            }
            return true;
        }
    }

    IEnumerator SpawnWave (waveUnit _wave)
    {
        Debug.Log("Spawning wave: " + _wave.name);
        state = SpawnState.SPAWNING;
        for (int i = 0; i<_wave.count; i++)
        {
            SpawnEnemy(_wave.enemy);
            yield return new WaitForSeconds(1f / _wave.rate);
        }
        state = SpawnState.WAITING;
        yield break;
    }

    void SpawnEnemy (Transform _enemy)
    {
        //SpawnEnemy
        Instantiate(_enemy, transform.position, transform.rotation);
        Debug.Log("Spawning enemy: " + _enemy.name);
    }

}
