using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : BasedGameObjects
{
    public GameObject ExploisionPartickle;
    [SerializeField]
    float immortalTime;
    public ParticleSystem ImmortalVisualParticle;
    private float timeBeforKick;
    float currentXposition;
    public Animator anim;
    [SerializeField]
    private float mergeAnimationSpeed;
    public static PlayerController instance;
	public BaseWeapon Weapon;

	public override float HealthPoints
	{
		get { return healthPoints; }
		set { healthPoints = value;
			Done_GameController.Instance.UpdateHealth (value);
			if (healthPoints <= 0) {
				Done_GameController.Instance.GameOver ();
				Death ();
			}
		}
	}

    void Awake()
    {
        PlayerController.instance = this;
    }

    void Update ()
    {
		if (Input.GetMouseButtonDown (0))
			Weapon.FireStart ();
		if (Input.GetMouseButtonUp (0))
			Weapon.FireEnd ();
		

        float currentMoveVector = anim.GetFloat("MoveVector");

        if (Input.GetKey(KeyCode.RightArrow))
        {
            currentXposition = Mathf.Clamp(currentXposition + (moveSpeedX * Time.deltaTime), Done_GameController.Instance.Xmin, Done_GameController.Instance.Xmax);
            anim.SetFloat("MoveVector", Mathf.Clamp (currentMoveVector + (mergeAnimationSpeed * Time.deltaTime),-1,1));
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            currentXposition = Mathf.Clamp(currentXposition - (moveSpeedX * Time.deltaTime), Done_GameController.Instance.Xmin, Done_GameController.Instance.Xmax);
            anim.SetFloat("MoveVector", Mathf.Clamp(currentMoveVector - (mergeAnimationSpeed * Time.deltaTime), -1, 1));
        }
        else
        {
            anim.SetFloat("MoveVector", currentMoveVector - (Mathf.Abs(currentMoveVector) > (mergeAnimationSpeed * Time.deltaTime) ?
                (mergeAnimationSpeed * Time.deltaTime * Mathf.Sign(currentMoveVector)) : currentMoveVector));
        }
        transform.localPosition = new Vector3 (currentXposition, transform.localPosition.y, transform.localPosition.z);

    }

    public override void Initialized()
    {
        Type = Types.player;
		Done_GameController.Instance.UpdateHealth (HealthPoints);
    }
    public override void Death()
    {
        Instantiate(ExploisionPartickle, transform.position, Quaternion.identity);
        Done_GameController.Instance.GameOver();
        Destroy(gameObject);
    }
	public override void AddedGamage (float Damage)
    {
        if (Time.time >= timeBeforKick)
        {
            AddImmoratl(immortalTime);
			HealthPoints -= Damage;
        }
    }
    public void AddImmoratl (float TimeForImmortal)
    {
        if (Time.time < immortalTime)
            timeBeforKick += TimeForImmortal;
        else
        {
            timeBeforKick = Time.time + TimeForImmortal;
            StartCoroutine(ImmortalVisual());
        }
    }
    public IEnumerator ImmortalVisual ()
    {
        ImmortalVisualParticle.Play(true);
        while (Time.time < timeBeforKick)
            yield return null;
        ImmortalVisualParticle.Stop(true, ParticleSystemStopBehavior.StopEmitting);
    }
}
